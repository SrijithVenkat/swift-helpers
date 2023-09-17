//
//  CreateGame.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import SwiftUI

struct CreateGame: View {
    @EnvironmentObject var gameData : GameScreenViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .hour, value: 0, to: Date())!
        let max = Calendar.current.date(byAdding: .hour, value: 4, to: Date())!
        return min...max
    }
    
    var body: some View {
        VStack
        {
            //            Text("create game")
            //                .font(.system(size: 40, weight: .thin, design: .monospaced))
            //                .bold()
            Picker("Choose Game", selection: $gameData.currUserGame.game_type) {
                ForEach(GameType.allCases, id: \.self) { choice in
                    HStack
                    {
                        Text(choice.rawValue)
                            .tint(.purple)
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .tag(choice)
                        Image(systemName: choice.icon_string)
                    }
                }
            }
            .pickerStyle(.inline)
            .frame(height: 120)
            .padding(.horizontal)
            HStack
            {
                Text("User Limit")
                Picker("User Limit", selection: $gameData.currUserGame.user_limit, content: {
                    ForEach(4..<25, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                })
                .pickerStyle(.wheel)
            }
            .frame(maxWidth: 200)
            .padding()
            .frame(height: 100)
            Picker("Choose Outdoors or Indoors", selection: $gameData.currUserGame.outdoors, content: {
                Text("Outdoors")
                    .tag(true)
                Text("Indoors")
                    .tag(false)
            })
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal)
            .pickerStyle(.segmented)
            Picker("Choose Private or Public", selection: $gameData.currUserGame.private_game, content: {
                Text("Private")
                    .tag(true)
                Text("Public")
                    .tag(false)
            })
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal)
            .pickerStyle(.segmented)
            HStack {
                Text("Select Expiry")
                DatePicker("",selection: $gameData.currUserGame.expiry_time,
                           in: dateClosedRange,
                           displayedComponents: .hourAndMinute)
                .padding(.horizontal, 0)
            }
            .frame(width: 250)
            TextField("Enter Description", text: $gameData.description.value, axis: .vertical)
                .padding()
                .background(Color.black.opacity(0.05))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .overlay {
                    GeometryReader { geometry in
                        Text("500 Character Max")
                            .foregroundColor(.gray.opacity(0.6))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .position(x: geometry.size.width*0.80, y: geometry.size.height*0.85)
                        
                        
                    }
                }
                .padding()
                .cornerRadius(5)
            Button {
                if gameData.userHasGame
                {
                    gameData.updateGame()
                }
                else
                {
                    gameData.createGame()
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(gameData.userHasGame ? "Update Game" : "Create Game")
            }
            .foregroundColor(.white)
            .frame(width: 200, height: 55)
            .background(.purple.opacity(0.7))
            .cornerRadius(10)
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

struct CreateGame_Previews: PreviewProvider {
    static var previews: some View {
        CreateGame()
            .environmentObject(GameScreenViewModel())
    }
}
