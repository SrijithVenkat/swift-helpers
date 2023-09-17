//
//  HomeScreen.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showProfileModal : Bool = false
    
    var body: some View {
        ZStack
        {
            VStack
            {
                Button
                {
                    showProfileModal.toggle()
                }
                label: {
                    Image(systemName: "person.crop.circle")
                        .tint(.purple)
                        .scaleEffect(2)
                }
                .sheet(isPresented: $showProfileModal)
                {
                    ProfileView()
                }
                .padding(.leading, 250)
                .padding(.top, 50)
                Spacer()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
