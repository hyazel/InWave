//
//  Waves.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 26/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

// MARK: - Waves
struct Wave: Shape {
    var firstCurveX: CGFloat = 0.3
    var secondCurveX: CGFloat = 0.75
    
    var yOffset: CGFloat = -1
    
    var animatableData: CGFloat {
        get {
            yOffset
        }
        set {
            yOffset = newValue
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY),
                      control1: CGPoint(x: rect.maxX * secondCurveX, y: 100 * yOffset),
                      control2: CGPoint(x: rect.maxX * firstCurveX, y: -50 * yOffset) )
        path.closeSubpath()
        
        return path
    }
}
