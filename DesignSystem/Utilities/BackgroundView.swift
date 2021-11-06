//
//  BackgroundView.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 06/11/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct BackgroundView: UIViewRepresentable {
    private let color: Color
    
    public init(color: Color) {
        self.color = color
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // find first superview with color and make it transparent
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor(color)
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}
