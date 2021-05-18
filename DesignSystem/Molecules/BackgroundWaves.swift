//
//  BackgroundWaves.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 13/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct BackgroundWaves: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            VStack {
                HStack {
                    Wave()
                        .fill(Color.Palette.lagoon).opacity(0.35)
                        .frame(width: 50, height: 500)
                    Spacer()
                }
                Spacer()
            }.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.lagoon).opacity(0.35)
                        .frame(width: UIScreen.main.bounds.width - 50,
                               height: UIScreen.main.bounds.width - 50)
                        .offset(x: UIScreen.main.bounds.width - 100, y: -200)
                }
                Spacer()
            }.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.lagoon).opacity(0.35)
                        .frame(width: 300, height: 500)
                        .offset(x: 100, y: 400)
                }
                
            }
        }
        .ignoresSafeArea()
    }
}
