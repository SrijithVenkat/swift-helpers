//
//  GameScreen.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import SwiftUI
import Firebase


@MainActor
final class GameScreenViewModel : ObservableObject {
    @Published var currUserGame : Game = Game()
    @Published var allGames : [Game] = []
    @Published var userHasGame : Bool = false
    @Published var currUser : RivalUser = RivalUser()
    @ObservedObject var description = TextLimiter(limit: 500)
    
    public func setGameRef()
    {
        Task {
            let gameInst = try await GameDBManager.getGameInstance(userID: currUser.rivalUserID)
            if gameInst != nil
            {
                currUserGame = gameInst!
                userHasGame = true
                getAllGames()
            }
            else
            {
                print("NO EXISTING GAME FOR \(currUser.rivalUserID)")
            }
        }
    }
    
    public func setUserRef(user : RivalUser)
    {
        currUser = user
    }
    
    public func createGame()
    {
        Task {
            if !userHasGame {
                let res = try await GameDBManager.createGame(gameInst: currUserGame, userID: currUser.rivalUserID)
                if res {
                    userHasGame.toggle()
                    currUser = currUser.updateGameID()
                    currUserGame = currUserGame.updateGameID(newID: currUser.rivalUserID)
                    try await UserDBManager.updateUserData(userID: currUser.rivalUserID, newData: currUser.documentForm())
                    print("Successfully created/added game to User")
                } else {
                    print("Failed to add Game")
                }
            }
        }
    }
    
    public func updateGame()
    {
        Task {
            if !userHasGame {
                let res = try await GameDBManager.updateGameData(userID: currUser.rivalUserID, newData: currUserGame.documentForm())
                if res {
                    print("Successfully updated game to User")
                } else {
                    print("Failed to add Game")
                }
            }
        }
    }
    
    
    public func getAllGames()
    {
        GameDBManager.getAllGames { dbRes in
            if !dbRes.isEmpty {
                self.allGames = dbRes
            }
        }
    }
    
}


struct GameScreen: View {
    @ObservedObject var userData : UserViewModel
    @StateObject var gameData : GameScreenViewModel = GameScreenViewModel()
    
    let Game1 : Game = Game(user_limit: 5, currentUserCount: 2, private_game: false, description: "Pick up soccer in lincoln park", game_type: .soccer, expiry_time: Date.now.addingTimeInterval(2340), outdoors: false, location: GeoPoint(latitude: 41.891401, longitude: -87.341693))
    let Game2 : Game = Game(user_limit: 12, currentUserCount: 8, private_game: false, description: "pick up basketball in lincoln park", game_type: .basketball, expiry_time: Date.now.addingTimeInterval(4350), outdoors: true, location: GeoPoint(latitude: 41.881401, longitude: -87.641693))
    let Game3 : Game = Game(user_limit: 20, currentUserCount: 11, private_game: false, description: "wrestling club", game_type: .archery, expiry_time: Date.now.addingTimeInterval(4350), outdoors: false, location: GeoPoint(latitude: 41.881401, longitude: -87.641693))
    let Game4 : Game = Game(user_limit: 4, currentUserCount: 3, private_game: false, description: "at the range", game_type: .golf, expiry_time: Date.now.addingTimeInterval(4350), outdoors: false, location: GeoPoint(latitude: 41.881401, longitude: -87.641693))
    
    init(userData: UserViewModel) {
        self.userData = userData
    }
    
    var body: some View {
        VStack
        {
            NavigationView
            {
                VStack
                {
                    Divider()
                        .foregroundColor(.purple)
                    Button {
                    } label: {
                        HStack
                        {
                            Image(systemName: gameData.userHasGame ? "pencil" : "plus.diamond.fill")
                                .scaleEffect(1.5)
                            NavigationLink(gameData.userHasGame ? "Edit Game" : "Create Game")
                            {
                                GameDataModify()
                                    .environmentObject(gameData)
                            }
                            .padding(.leading, 10)
                            Image(systemName: "chevron.right")
                                .padding(.leading, 50)
                                .scaleEffect(1)
                        }
                    }
                    .padding(.vertical, 20)
                    .padding(.leading, 40)
                    .foregroundColor(.purple)
                
                    Divider()
                        .foregroundColor(.purple)
                    HStack
                    {
                        Button
                        {
                            gameData.getAllGames()
                        } label:
                        {
                            Text("Refresh")
                            Image(systemName: "arrow.counterclockwise")
                                .scaleEffect(1)
                        }
                        
                    }
                    .foregroundColor(.purple)
                    Divider()
                        .foregroundColor(.purple)
                    ScrollView
                    {
                        ForEach(gameData.allGames) { game in
                            GameView(gameToDisplay: game)
                        }
                    }
                }
                .navigationTitle("Games")
            }
        }
        .onAppear {
            if userData.currRivalUser.rivalUserID != ""
            {
                gameData.setUserRef(user: userData.currRivalUser)
                gameData.setGameRef()
            }
        }
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(userData: UserViewModel())
    }
}
