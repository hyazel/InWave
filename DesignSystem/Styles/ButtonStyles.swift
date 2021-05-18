//
//  PressableButtonStyle.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 31/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct PressableButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: PressableButtonStyle.Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(Animation.easeIn(duration: 0.1))
    }
}

public struct PrimaryButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .font(Font.button())
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .foregroundColor(Color.white)
            .background(Color.Accent.primary())
            .cornerRadius(54)
            .shadow(color: Color.black.opacity(0.15), radius: 4.0, x: 0, y: 4)
            .opacity(configuration.isPressed ? 0.2 : 1)
    }
}

public struct SecondaryButtonStyle: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 10))
            .opacity(configuration.isPressed ? 0.2 : 1)
            .animation(.default)
            .font(Font.button())
            .foregroundColor(Color.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .background(Color.Accent.secondary())
            .cornerRadius(54)
            .shadow(color: Color.black.opacity(0.15), radius: 4.0, x: 0, y: 4)
    }
}

//public struct TestButtonStyle: ButtonStyle {
//    let text: String
//    
//    public init(text: String) {
//        self.text = text
//    }
//    
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        Text(text)
//            .font(Font.button())
//            .foregroundColor(.white)
//            .frame(width: 166, height: 54)
//            .background(Color.Palette.lagoon)
//            .cornerRadius(54)
//            .opacity(configuration.isPressed ? 0.2 : 1)
//    }
//}

public struct PrimaryButtonModifier: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .font(Font.button())
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
            .foregroundColor(Color.white)
            .background(Color.Accent.primary())
            .cornerRadius(54)
            .shadow(color: Color.black.opacity(0.15), radius: 4.0, x: 0, y: 4)
    }
}
