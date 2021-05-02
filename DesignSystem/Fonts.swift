//
//  Fonts.swift
//  PodcastersAnalytics
//
//  Created by Laurent Droguet on 14/04/2020.
//  Copyright © 2020 Laurent Droguet. All rights reserved.
//

import SwiftUI

extension Font {
    // MARK: Headline1
    public static func headline1() -> Font {
        .system(size: 64, weight: .light)
    }
    
    // MARK: Headline2
    public static func headline2() -> Font {
        .system(size: 36)
    }
    
    // MARK: Title1
    public static func title1() -> Font {
        .system(size: 24, weight: .medium)
    }
    
    // MARK: Title2
    public static func title2() -> Font {
        .system(size: 18, weight: .medium)
    }
    
    // MARK: Title3
    public static func title3() -> Font {
        .system(size: 14, weight: .regular)
    }
    
    // MARK: Detail
    public static func detail() -> Font {
        .system(size: 14, weight: .bold)
    }
    
    // MARK: Body
    public static func body() -> Font {
        .system(size: 14, weight: .regular)
    }
}
