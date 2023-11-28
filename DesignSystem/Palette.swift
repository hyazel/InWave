//
//  Palette.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 07/01/2021.
//

import SwiftUI

// MARK: - Color Palette
extension Color {
    public enum Palette {
        public static let snow: Color = Color(hex: 0xFFFFFF)
        public static let lagoon: Color = Color(hex: 0x39BCD8)
        public static let pearl: Color = Color(hex: 0xD5DDC9)
        public static let ocean: Color = Color(hex: 0x004B83)
        public static let lake: Color = Color(hex: 0x014D5A)
        public static let shell: Color = Color(hex: 0xA0B4A9)
        public static let darkOcean: Color = Color(hex: 0x0A2A43)
        public static let sunset: Color = Color(hex: 0xFF9B5A)
        public static let test: Color = Color(hex: 0xa6d1f2)
    }
}

extension Color {
    public init(hue: Double, saturation: Double, lightness: Double, opacity: Double) {
        precondition(0...1 ~= hue &&
                     0...1 ~= saturation &&
                     0...1 ~= lightness &&
                     0...1 ~= opacity, "input range is out of range 0...1")
        
        //From HSL TO HSB ---------
        var newSaturation: Double = 0.0
        
        let brightness = lightness + saturation * min(lightness, 1-lightness)
        
        if brightness == 0 { newSaturation = 0.0 }
        else {
            newSaturation = 2 * (1 - lightness / brightness)
        }
        //---------
        
        self.init(hue: hue, saturation: newSaturation, brightness: brightness, opacity: opacity)
    }
}
