//
//  RivalUserModel.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import Foundation
import SwiftUI

//Immutable Struct
struct RivalUser : Codable
{
    var rivalUserID: String
    var email: String
    var firstName : String
    var lastName : String
    var gender : Int // 0 - Male, 1 - Female, 2 - Other/Prefer Not To Say
    var age : Int
    var phoneNumber : String
    var lastLoggedOn : Date
    var gameUserID : String
    
    //Constructor
    init(id : String = "", email: String = "", firstName: String = "", lastName: String = "", gender: Int = 2, age: Int = 1, phoneNumber: String = "", lastLoggedOn : Date = Date.now, gameUserID : String = "") {
        self.rivalUserID = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.age = age
        self.phoneNumber = phoneNumber
        self.lastLoggedOn = lastLoggedOn
        self.gameUserID = gameUserID
    }
    
    init(rivalUser : RivalUser?) {
        let t_ref = rivalUser!
        self.rivalUserID = t_ref.rivalUserID
        self.email = t_ref.email
        self.firstName = t_ref.firstName
        self.lastName = t_ref.lastName
        self.gender = t_ref.gender
        self.age = t_ref.age
        self.phoneNumber = t_ref.phoneNumber
        self.lastLoggedOn = Date.now
        self.gameUserID = t_ref.gameUserID
    }
    public func updateGameID() -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: rivalUserID)
    }
    public func updateEmail(newEmail : String) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: newEmail, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updateFirstName(newFirstName : String) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: newFirstName, lastName: lastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updateLastName(newLastName : String) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: newLastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updateGender(newGender : Int) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: lastName, gender: newGender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updateAge(newAge : Int) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: lastName, gender: gender, age: newAge, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updatePhoneNumber(newPhoneNumber : String) -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber: newPhoneNumber, lastLoggedOn: lastLoggedOn, gameUserID: gameUserID)
    }
    public func updateLastLoggedOn() -> RivalUser
    {
        return RivalUser(id: rivalUserID, email: email, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: Date.now, gameUserID: gameUserID)
    }
    
    public func documentForm() -> [String : Any]
    {
        let documentDict: [String: Any] = ["rival_user_id" : rivalUserID, "email": email, "first_name" : firstName,"last_name" : lastName, "gender" : gender, "age" : age,"phone_number" : phoneNumber, "last_logged_on" : lastLoggedOn,  "game_user_id": gameUserID]
        return documentDict
    }
}
