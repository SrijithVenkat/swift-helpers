//
//  InitialCreateOrLoginView.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import SwiftUI

struct InitialCreateOrLoginView: View {
    @EnvironmentObject var userData : UserViewModel
    @State var signingIn : Bool = true
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack
        {
            TextField("Email", text: $email)
                .modifier(TextFieldModifiers())
            
            SecureField("Password", text: $password)
                .modifier(TextFieldModifiers())
            
            if !signingIn
            {
                TextField("First Name", text: $userData.currRivalUser.firstName)
                    .modifier(TextFieldModifiers())
                
                TextField("Last Name", text: $userData.currRivalUser.lastName)
                    .modifier(TextFieldModifiers())
                
                TextField("Phone Number", text: $userData.currRivalUser.phoneNumber)
                    .modifier(TextFieldModifiers())
                
                Picker("Gender", selection: $userData.currRivalUser.gender, content: {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                        .background(Color.blue)
                    Text("Other").tag(2)
                })
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .pickerStyle(.segmented)
                
                Picker("Age", selection:$userData.currRivalUser.age, content: {
                    ForEach(14..<121, id: \.self) { number in
                        Text("\(number)").tag("\(number)")
                    }
                })
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .pickerStyle(.wheel)
            }
            Button(signingIn ? "Sign In" : "Register Account")
            {
                if signingIn
                {
                    userData.signInEmailUser(email: email, pass: password) { success in
                        if success {
                            userData.isLoggedIn.toggle()
                        }
                        else {
                            print("Failed to Sign In")
                        }
                    }
                }
                else
                {
                    userData.createEmailUser(email: email, password: password) { success in
                        if success {
                            userData.isLoggedIn.toggle()
                        }
                        else {
                            print("Failed to Create User")
                        }
                    }
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.purple.opacity(0.5))
            .cornerRadius(10)

            Button(signingIn ? "Don't have an Account? Register Here" : "Have an Account? Sign in Here ")
            {
                signingIn.toggle()
            }
            .foregroundColor(Color.black.opacity(0.5))
        }
        .padding()
    }
}

struct InitialCreateOrLoginView_Previews: PreviewProvider {
    static var previews: some View {
        InitialCreateOrLoginView()
            .environmentObject(UserViewModel())
    }
}
