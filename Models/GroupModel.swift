//
//  GroupModel.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import Foundation

struct Group
{
    let groupID : String
    var user_limit : Int
    var current_user_count : Int
    var private_group : Bool
    var description : String
    var game_type : GameType
    
    init(group_id : String = "", user_limit: Int = 2, currentUserCount: Int = 1, private_group: Bool = false, description: String = "", game_type: GameType = .none) {
        self.groupID = group_id
        self.user_limit = user_limit
        self.current_user_count = currentUserCount
        self.private_group = private_group
        self.description = description
        self.game_type = game_type
    }
    
    //SETTERS
    public func updateUserLimit(newUserLimit : Int) -> Group
    {
        return Group(user_limit: newUserLimit)
    }
    public func updateCurrentUserCount(newUserCount : Int) -> Group
    {
        return Group(currentUserCount: newUserCount)
    }
    public func getIfPrivate(newPrivateStatus : Bool) -> Group
    {
        return Group(private_group: newPrivateStatus)
    }
    public func getDescription(newDesc : String) -> Group
    {
        return Group(description: newDesc)
    }
    public func updateGameType(newGameType : GameType) -> Group
    {
        return Group(game_type: newGameType)
    }
    
    
    
    
}
