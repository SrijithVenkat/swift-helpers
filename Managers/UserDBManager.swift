//
//  UserDBManager.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift



final class UserDBManager
{
    
    public static func createEmailUser(authRes : RivalUser) async throws -> Void
    {
        try await FirestoreDB.collection("Users").document(authRes.rivalUserID).setData(authRes.documentForm())
    }
    
    public static func updateUserData(userID : String, newData : [String: Any]) async throws -> Void
    {
        do {
            try await FirestoreDB.collection("Users").document(userID).updateData(newData)
        } catch {
            print("Failed to Update User Data at ID: \(userID)")
        }
    }
    
    public static func deleteUser(userID : String) async throws -> Void
    {
        do {
            try await FirestoreDB.collection("Users").document(userID).delete()
        } catch {
            print("Failed to Delete User for ID: \(userID)")
        }
    }
    
    public static func getUser(user_id : String) async throws-> RivalUser? {
        let snapshot = try await FirestoreDB.collection("Users").document(user_id).getDocument()
        
        guard let data = snapshot.data() else {
            return nil
        }
        
        let id = data["rival_user_id"] as! String
        let email =  data["email"] as! String
        let firstName = data["first_name"] as! String
        let lastName =  data["last_name"] as! String
        let gender =  data["gender"] as! Int
        let age =   data["age"] as! Int
        let phoneNumber =  data["phone_number"] as! String
        let lastLoggedOn =  data["last_logged_on"] as? Timestamp
        let game_user_id =  data["game_user_id"] as! String
        
        return RivalUser(id: id, email: email, firstName: firstName, lastName: lastName, gender: gender, age: age, phoneNumber: phoneNumber, lastLoggedOn: lastLoggedOn?.dateValue() ?? Date.now.addingTimeInterval(3600), gameUserID: game_user_id)
    }
     
}


