//
//  GameDBManager.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import Foundation

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

final class GameDBManager
{
    public static func createGame(gameInst: Game, userID : String) async throws -> Bool
    {
        do {
            try await FirestoreDB.collection("Games").document(userID).setData(gameInst.documentForm())
            return true
        } catch {
            print("Failed to Create Game for ID: \(userID)")
            return false
        }
    }
    
    public static func deleteGame(userID : String) async throws -> Void
    {
        do {
            try await FirestoreDB.collection("Games").document(userID).delete()
        } catch {
            print("Failed to Delete Game for ID: \(userID)")
        }
    }
    
    public static func updateGameData(userID : String, newData : [String: Any]) async throws -> Bool
    {
        do {
            try await FirestoreDB.collection("Games").document(userID).updateData(newData)
            return true
        } catch {
            print("Failed to Update Game Data at ID: \(userID)")
            return false
        }
    }
    
    public static func getGameInstance(userID : String) async throws -> Game?
    {
        let snapshot = try await FirestoreDB.collection("Games").document(userID).getDocument()
        
        guard let game_data = snapshot.data() else {
            return nil
        }
        return Game(data: game_data)
    }
    
    public static func getAllGames(completion: @escaping ([Game]) -> Void)
    {
        var allGames: [Game] = []
        let excludedDocumentID = AuthenticationManager.getCurrentUserID()
        
        FirestoreDB.collection("Games").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion([])
            } else {
                for document in querySnapshot!.documents {
                    if document.documentID != excludedDocumentID {
                        let documentData = document.data()
                        let gameRef = Game(data: documentData)
                        allGames.append(gameRef)
                    }
                }
                completion(allGames)
            }
        }
    }
    
}

//        let query = allGamesRef.whereField(FieldPath.documentID(), isNotEqualTo: excludedDocumentID)
//        let query = allGamesRef.where(FieldPath.documentID(), "!=", excludedDocumentID).get()
////            .whereField("private_group", isEqualTo: false)
//
//        // Execute the query to get the documents except the excluded one
//        query.getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//                return
//            }
//
//            guard let documents = snapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            for document in documents {
//                let documentData = document.data()
//                let gameRef = Game(gameData: documentData)
//                allGames.append(gameRef)
////                print("Document ID: \(document.documentID)")
////                print("Document Data: \(documentData)")
//            }
//        }
