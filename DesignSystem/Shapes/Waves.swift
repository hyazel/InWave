//
//  Waves.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 26/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX + 100, y: 50),
                      control2: CGPoint(x: rect.maxX, y: 400) )
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}
