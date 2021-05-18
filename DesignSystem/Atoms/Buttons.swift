//
//  PrimaryButton.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 18/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> ()
    
    public init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action,
               label: {
                Text(title)
               })
            .modifier(PrimaryButtonModifier())
    }
}

public struct SecondaryButton: View {
    let title: String
    let action: () -> ()
    
    public init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action,
               label: {
                Text(title)
                    .font(Font.button())
                    .foregroundColor(.white)
                    .frame(width: 166, height: 54)
                    .background(Color.Palette.lagoon)
                    .cornerRadius(54)
               })
    }
}
