//
//  Colors.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 07/01/2021.
//

import SwiftUI

extension Color {
    /// Initializes a UIColor from its hexadecimal color code.
    public init(hex: Int) {
        let red = (hex >> 16)
        let green = (hex >> 8) - (red << 8)
        let blue = hex - (red << 16) - (green << 8)
        
        self.init(.sRGB, red: Double(red) / 255, green: Double(green) / 255, blue:  Double(blue) / 255, opacity: 1)
    }
    
    public init?(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}
