//
//  MainView.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import SwiftUI

@MainActor
final class UserViewModel : ObservableObject
{
    @Published var currRivalUser : RivalUser = RivalUser()
    @Published var isLoggedIn : Bool = false
    let genderOptions : [Int: String] = [0: "Male", 1: "Female", 2: "Other/Prefer Not To Say"]
    
    public func toggleLoggedIn()
    {
        isLoggedIn.toggle()
    }
    
    public func getGender() -> String
    {
        return genderOptions[currRivalUser.gender] ?? "Other/Prefer Not To Say"
    }
    
    func signInEmailUser(email : String, pass : String, completion: @escaping (Bool) -> Void)
    {
        Task
        {
            try await AuthenticationManager.signInEmailUser(email: email, password: pass)
            
            
            let getUserRes = try await AuthenticationManager.getCurrentUser()
            if getUserRes != nil {
                currRivalUser = getUserRes!
                print("Successfully Signed In User")
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    
    func createEmailUser(email : String, password : String, completion: @escaping (Bool) -> Void)
    {
        Task
        {
            try await AuthenticationManager.createEmailUser(email: email, password: password, firstName: currRivalUser.firstName, lastName: currRivalUser.lastName, gender: currRivalUser.gender, phoneNumber: currRivalUser.phoneNumber, age: currRivalUser.age)
            let getUserRes = try await AuthenticationManager.getCurrentUser()
            if getUserRes != nil {
                currRivalUser = getUserRes!
                print("Successfully Created & Assigned User")
                completion(true)
            }
            else
            {
                completion(false)
            }
        }
    }
    
    func updateUserData()
    {
        Task
        {
            try await AuthenticationManager.updateCurrentUserData(data: currRivalUser.documentForm())
        }
    }
    
    func signOutEmailUser() -> Bool
    {
        do {
            try AuthenticationManager.signOutEmailUser()
            currRivalUser = RivalUser()
            return true
        } catch {
            print("Failed to Sign Out")
            return false
        }
    }
    
    func setRivalUser(user : RivalUser)
    {
        currRivalUser = user
    }
    
}


struct MainView: View {
    
    @StateObject var userData : UserViewModel = UserViewModel()
    
    var body: some View {
        ZStack
        {
            if userData.isLoggedIn
            {
                TabView {
                    GameScreen(userData: userData)
                        .tabItem {
                            Image(systemName: "figure.run")
                                .foregroundColor(.gray)
                        }
                    HomeScreen()
                        .environmentObject(userData)
                        .tabItem {
                            Image(systemName: "house")
                                .foregroundColor(.gray)
                        }
                    Text("Settings")
                        .tabItem {
                            Image(systemName: "gear")
                                .foregroundColor(.gray)
                        }
                }
            }
            else {
                InitialCreateOrLoginView()
                    .environmentObject(userData)
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
