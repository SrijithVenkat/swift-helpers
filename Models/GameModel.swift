//
//  GameModel.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import Foundation
//
//  GameModel.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import Foundation
import Firebase

struct Game : Equatable, Identifiable
{
    let id = UUID()
    let GameID : String
    var user_limit : Int
    var current_user_count : Int
    var private_game : Bool
    var description : String
    var game_type : GameType
    var expiry_time : Date
    var outdoors : Bool
    var location : GeoPoint
    var gameUsers : [String]
    //Future Fields
    // Competitive / Casual
    // Matchmaking
    // Scheduling?
    
    init(Game_id : String = "", user_limit: Int = 2, currentUserCount: Int = 1, private_game: Bool = false, description: String = "", game_type: GameType = .none, expiry_time : Date = Date.now.addingTimeInterval(7200), outdoors : Bool = false, location : GeoPoint = GeoPoint(latitude: 0.0, longitude: 0.0), gamePlayers : [String] = []) {
        self.GameID = Game_id
        self.user_limit = user_limit
        self.current_user_count = currentUserCount
        self.private_game = private_game
        self.description = description
        self.game_type = game_type
        self.expiry_time = expiry_time
        self.outdoors = outdoors
        self.location = location
        self.gameUsers = gamePlayers
    }
    
    init(gameInst : Game)
    {
        self.GameID = gameInst.GameID
        self.user_limit = gameInst.user_limit
        self.current_user_count = gameInst.current_user_count
        self.private_game = gameInst.private_game
        self.description = gameInst.description
        self.game_type = gameInst.game_type
        self.expiry_time = gameInst.expiry_time
        self.outdoors = gameInst.outdoors
        self.location = gameInst.location
        self.gameUsers = gameInst.gameUsers
    }
    
    init(data : [String : Any])
    {
        self.GameID = data["game_id"] as! String
        self.user_limit = data["user_limit"] as! Int
        self.current_user_count = data["current_user_count"] as! Int
        self.private_game = data["private_group"] as! Bool
        self.description = data["description"] as! String
        let gt = data["game_type"] as! String
        self.game_type = GameType(rawValue: gt)!
        
        let tstamp = data["expiry_time"] as? Timestamp
        self.expiry_time = tstamp?.dateValue() ?? Date.now.addingTimeInterval(7200)
        
        self.outdoors = data["outdoors"] as! Bool
        self.location = data["location"] as! GeoPoint
        self.gameUsers = data["game_users"] as! [String]
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        if lhs.GameID == rhs.GameID && lhs.user_limit == rhs.user_limit && lhs.current_user_count == rhs.current_user_count && lhs.private_game == rhs.private_game && lhs.description == rhs.description
            && lhs.expiry_time == rhs.expiry_time && lhs.outdoors == rhs.outdoors && lhs.location == rhs.location
        {
            return true
        }
        return false
    }
    
    //SETTERS
    public func updateGameID(newID : String) -> Game
    {
        return Game(Game_id: newID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func updateUserLimit(newUserLimit : Int) -> Game
    {
        return Game(Game_id: GameID, user_limit: newUserLimit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func updateCurrentUserCount(newUserCount : Int) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: newUserCount, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func getIfPrivate(newPrivateStatus : Bool) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: newPrivateStatus, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func getDescription(newDesc : String) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: newDesc, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func updateGameType(newGameType : GameType) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: newGameType, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func updateExpiryTime(newExpiry : Date) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: newExpiry, outdoors: outdoors, location: location, gamePlayers: gameUsers)
    }
    public func updateOutdoors(newOutdoorsStatus : Bool) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: newOutdoorsStatus, location: location, gamePlayers: gameUsers)
    }
    public func updateLocation(newLoc : GeoPoint) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: newLoc, gamePlayers: gameUsers)
    }
    
    public func updateLocation(newGameUsers : [String]) -> Game
    {
        return Game(Game_id: GameID, user_limit: user_limit, currentUserCount: current_user_count, private_game: private_game, description: description, game_type: game_type, expiry_time: expiry_time, outdoors: outdoors, location: location, gamePlayers: newGameUsers)
    }
    
    public func documentForm() -> [String : Any]
    {
        let documentDict: [String: Any] = ["game_id" : GameID, "user_limit" : user_limit, "current_user_count" : current_user_count, "private_group": private_game, "description" : description,
                                           "game_type" : game_type.rawValue, "expiry_time" : expiry_time, "outdoors" : outdoors, "location" : location, "game_users" : gameUsers]
        return documentDict
    }
}
