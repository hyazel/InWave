//
//  BreathSymbolsView.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 12/04/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct BreathSymbolsView: View {
    let indexAvailable: [Int]
    @Binding var indexHighlighted: Int
    
    public init(indexAvailable: [Int], indexHighlighted: Binding<Int>) {
        self.indexAvailable = indexAvailable
        self._indexHighlighted = indexHighlighted
    }
    
    public var body: some View {
        let inhaleBinding = Binding<Bool>(
            get: {
                indexHighlighted == 1
            },
            set: { _ in }
        )
        let holdUpBinding = Binding<Bool>(
            get: {
                indexHighlighted == 2
            },
            set: { _ in }
        )
        let exhaleBinding = Binding<Bool>(
            get: {
                indexHighlighted == 3
            },
            set: { _ in }
        )
        let holdDownBinding = Binding<Bool>(
            get: {
                indexHighlighted == 4
            },
            set: { _ in }
        )
        
        HStack {
            if indexAvailable.contains(1) { BreathSymbolView(name: "inhale", highlighted: inhaleBinding) }
            if indexAvailable.contains(2) { BreathSymbolView(name: "hold_up", highlighted: holdUpBinding) }
            if indexAvailable.contains(3) { BreathSymbolView(name: "exhale", highlighted: exhaleBinding) }
            if indexAvailable.contains(4) { BreathSymbolView(name: "hold_down", highlighted: holdDownBinding) }
        }
    }
}

struct BreathSymbolView: View {
    let name: String
    @Binding var highlighted: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color.white,
                                  lineWidth: 1)
                    .background(Circle().foregroundColor(highlighted ? Color.Palette.lagoon : Color.Palette.lake))
                    .frame(width: 36, height: 36)
                Image(name)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
    }
}

struct BreathSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            BreathSymbolsView(indexAvailable: [1, 2, 3, 4], indexHighlighted: .constant(1))
        }
    }
}
