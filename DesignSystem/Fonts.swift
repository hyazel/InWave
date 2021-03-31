//
//  Fonts.swift
//  PodcastersAnalytics
//
//  Created by Laurent Droguet on 14/04/2020.
//  Copyright © 2020 Laurent Droguet. All rights reserved.
//

import SwiftUI

/// Allows the modification of the font size for one of the design system fonts
@objc public enum FontSizeModifier: Int {
    /// This is the default font size modifier
    case small = 0
    case medium = 1
    case large = 2
    case extraLarge = 3
}

extension Font {
    // MARK: Headline1
    public static func headline1(_ fontModifier: FontSizeModifier = .small) -> Font {
        var fontSize: CGFloat = 0.0
        
        switch fontModifier {
        case .small: fontSize = 32.0
        case .medium: fontSize = 48.0
        case .large: fontSize = 60.0
        case .extraLarge: fontSize = 72
        }
        
        return .system(size: fontSize)
    }
    
    // MARK: Headline2
    public static func headline2() -> Font {
        .system(size: 24, weight: .bold, design: .default)
    }
    
    // MARK: Headline3
    public static func headline3(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 18, weight: .bold, design: .default)
    }
    
    // MARK: Paragraph1
    public static func paragraph1(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 18)
    }
    
    // MARK: Paragraph2
    public static func paragraph2(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 14)
    }
    
    // MARK: Paragraph3
    public static func paragraph3(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 14)
    }
    
    // MARK: Paragraph4
    public static func paragraph4(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 12, weight: .bold, design: .default)
    }
    
    // MARK: Paragraph5
    public static func paragraph5(shouldScaleWithTraitCollection: Bool = false) -> Font {
        .system(size: 12)
    }
}
