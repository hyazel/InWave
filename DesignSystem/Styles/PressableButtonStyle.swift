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
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
