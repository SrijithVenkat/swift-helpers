//
//  main.swift
//  helpers
//
//  Created by Srijith Venkateshwaran on 9/17/23.
//

import SwiftUI
//import FirebaseCore
//import FirebaseFirestore
//import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
let FirestoreDB = Firestore.firestore()

@main
struct rivalv2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
