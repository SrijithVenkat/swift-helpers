//
//  GameView.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/19/23.
//

import SwiftUI
import Firebase


struct GameView: View {
    @State var showView : Bool = false
    
    let gameToDisplay : Game
    
    init(gameToDisplay: Game) {
        self.gameToDisplay = gameToDisplay
    }
    
    
    var body: some View {
        VStack
        {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundColor(Color.teal.opacity(0.7))
                .frame(width: .infinity, height: showView ? 200 : 100)
                .animation(Animation.easeInOut(duration: 0.4), value: showView)
                .cornerRadius(10)
                .overlay( GeometryReader { geometry in
                    HStack(alignment: .top)
                    {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .frame(width: geometry.size.width*0.2, height: geometry.size.height)
                            .animation(Animation.easeInOut(duration: 0.4), value: showView)
                            .foregroundColor(.black.opacity(0.4))
                            .overlay {
                                Image(systemName: gameToDisplay.game_type.icon_string)
                                    .scaleEffect(2.0)
                                    .animation(Animation.easeInOut(duration: 0.4), value: showView)
                            }
                            .padding(.trailing, 30)
                        VStack
                        {
                            Spacer()
                            HStack
                            {
                                Text(gameToDisplay.game_type.rawValue)
                                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                                    .foregroundColor(.black)
                                    .animation(Animation.easeInOut(duration: 0.4), value: showView)
                                    .frame(width: 180)
                                    .lineLimit(2)
                                Spacer()
                                Image(systemName: "chevron.up")
                                    .scaleEffect(2.0)
                                    .rotationEffect(.degrees(showView ? 180 : 360))
                                    .animation(Animation.easeInOut(duration: 0.4), value: showView)
                                    .onTapGesture { withAnimation { showView.toggle() } }
                                    .padding(0)
                                Spacer()
                            }
                            Spacer()
                            if showView
                            {
                                Spacer()
                                HStack
                                {
                                    Button(action: {
                                            // Action when the button is tapped
                                    }) {
                                        Text("Join")
                                            .font(.headline)
                                            .foregroundColor(.black.duller(saturationFactor: 1.3)) // Foreground color
                                            .padding(.vertical, 10)
                                            .padding(.trailing, 30)
                                            .frame(width: 180)
                                            .background(Color.white.opacity(0.9)) // Background color
                                            .cornerRadius(10) // Corner radius
                                    }
                                    .overlay
                                    {
                                        Image(systemName: "chevron.right")
                                            .padding(.leading, 130)
                                            .foregroundColor(.black.duller(saturationFactor: 1.3)) // Foreground color
                                            .scaleEffect(0.8)
                                    }
                                    .animation(Animation.easeInOut(duration: 0.4), value: showView)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    }
                })
        }
        .padding()
        .listRowSeparator(.hidden)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameToDisplay: Game())
    }
}
