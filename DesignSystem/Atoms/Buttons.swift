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
    let fixedWidth: Bool
    
    public init(title: String, fixedWidth: Bool = true, action: @escaping () -> ()) {
        self.title = title
        self.action = action
        self.fixedWidth = fixedWidth
    }
    
    public var body: some View {
        Button(action: action,
               label: {
                Text(title)
                    .font(Font.button())
                    .foregroundColor(.white)
                    .frame(maxWidth: fixedWidth ? 166 : .infinity, maxHeight: 54)
                    .background(Color.Palette.lagoon)
                    .cornerRadius(54)
               })
    }
}
