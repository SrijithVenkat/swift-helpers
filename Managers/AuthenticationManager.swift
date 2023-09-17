//
//  AuthenticationManager.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase

final class AuthenticationManager
{
     
    public static func createEmailUser(email : String, password : String, firstName : String, lastName : String, gender : Int, phoneNumber : String, age : Int) async throws -> Void
    {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let newUserData = RivalUser(id: authResult.user.uid, email: email, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber : phoneNumber, gameUserID: "")
            try await UserDBManager.createEmailUser(authRes: newUserData)
    }
    
    public static func signInEmailUser(email : String, password : String) async throws
    {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw(URLError(.cancelled))
        }
    }
    
    public static func signOutEmailUser() throws -> Void
    {
        try Auth.auth().signOut()
    }
    
    public static func getCurrentUser() async throws -> RivalUser?
    {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        if let rivalUser = try await UserDBManager.getUser(user_id: user.uid) {
            print("Successfully Retrieved User - \(user.uid)")
            return rivalUser
        }
        else
        {
            return nil
        }
    }
    
    public static func getCurrentUserID() -> String
    {
        guard let userID = Auth.auth().currentUser else  {
            print("Failed to Obtain UserID - Function: getCurrentUserID()")
            return ""
        }
        return userID.uid
    }
    
    public static func updateCurrentUserData(data : [String: Any]) async throws -> Void
    {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        do {
            try await UserDBManager.updateUserData(userID: user.uid, newData: data)
        } catch
        {
            print("Failed to Update USER Data at ID: \(user.uid)")
        }
    }
    
}
