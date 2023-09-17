//
//  Modifiers.swift
//  rivalv2
//
//  Created by Srijith Venkateshwaran on 8/18/23.
//

import Foundation
import SwiftUI

struct TextFieldModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(5)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

extension Color {
    func duller(saturationFactor: Double) -> Color {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract the components from the color
        _ = UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        // Adjust the saturation
        saturation *= CGFloat(saturationFactor)
        
        // Create a new color with adjusted saturation
        let newColor = Color(UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
        return newColor
    }
}

class TextLimiter: ObservableObject {
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
    @Published var hasReachedLimit = false
}
