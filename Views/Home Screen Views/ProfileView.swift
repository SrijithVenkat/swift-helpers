//
//  ProfileView.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userData : UserViewModel
    @State var showEditMenu : Bool = false
    
    var body: some View {
        VStack
        {
            Spacer()
            if showEditMenu {
                TextField("First Name", text: $userData.currRivalUser.firstName)
                    .modifier(TextFieldModifiers())
                
                TextField("Last Name", text: $userData.currRivalUser.lastName)
                    .modifier(TextFieldModifiers())
                
                TextField("Phone Number", text: $userData.currRivalUser.phoneNumber)
                    .modifier(TextFieldModifiers())
                
                    .keyboardType(.numberPad) // Set keyboard type to number pad
                Picker("Gender", selection: $userData.currRivalUser.gender, content: {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                        .background(Color.blue)
                    Text("Other").tag(2)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .pickerStyle(.segmented)
                
                Picker("Age", selection: $userData.currRivalUser.age, content: {
                    ForEach(14..<121, id: \.self) { number in
                        Text("\(number)").tag("\(number)")
                    }
                })
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .pickerStyle(.wheel)
            }
            else {
                Text("First Name: \(userData.currRivalUser.firstName)")
                Text("Age: \(userData.currRivalUser.age)")
                Text("Gender: \(userData.getGender())")
                Text("Email: \(userData.currRivalUser.email)")
                    .padding()
                Text("Date: \(Date.now))")
            }
            HStack
            {
                if showEditMenu
                {
                    Button("Go Back")
                    {
                        showEditMenu.toggle()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
                Button(showEditMenu ? "Update" : "Edit Profile")
                {
                    if showEditMenu {
                        userData.updateUserData()
                    }
                    showEditMenu.toggle()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.purple.opacity(0.5))
                .cornerRadius(10)
            }
            Button("Sign Out")
            {
                let res = userData.signOutEmailUser()
                if res {
                    userData.toggleLoggedIn()
                    showEditMenu = false
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.red.opacity(0.5))
            .cornerRadius(10)
            
            Spacer()
            Image(systemName: "chevron.down")
                .scaledToFit()
                .frame(height: 50)
                .scaleEffect(2, anchor: .bottom)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserViewModel())
    }
}
