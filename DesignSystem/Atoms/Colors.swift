//
//  Colors.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 07/01/2021.
//

import SwiftUI

extension Color {
    public enum Background {
        public static func primary() -> LinearGradient {
            LinearGradient(gradient: Gradient(colors: [Color.Palette.darkOcean, Color.Palette.lake]), startPoint: .bottom, endPoint: .top)
        }
        
        public static func blue1() -> LinearGradient {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x63C6FA), Color(hex: 0xA3ECFF)]), startPoint: .bottom, endPoint: .top)
        }
        
        public static func blue2() -> LinearGradient {
            LinearGradient(gradient: Gradient(colors: [Color(hex: 0x4EB7EE), Color(hex: 0x41CCEA)]), startPoint: .bottom, endPoint: .top)
        }
        
        public static func primaryAlpha() -> LinearGradient {
            LinearGradient(gradient: Gradient(colors: [Color.Palette.darkOcean, Color.Palette.darkOcean.opacity(0)]), startPoint: .bottom, endPoint: .top)
        }
        
        public static func card() -> Color {
            .white
        }
    }
    
    public enum Divider {
        public static func primary() -> Color {
            Color.Palette.shell
        }
    }
    
    public enum Text {
        public static func primary() -> Color {
            .white
        }
        
        public static func secondary() -> Color {
            .black
        }
        
        public static func accent() -> Color {
            Color.Palette.lagoon
        }
    }
    
    public enum Icon {
        public static func selected() -> Color {
            .white
        }
        
        public static func unselected() -> Color {
            Color.Palette.shell
        }
    }
    
    public enum Accent {
        public static func primary() -> Color {
            Color.Palette.sunset
        }
        
        public static func secondary() -> Color {
            Color.Palette.lagoon
        }
    }
}
