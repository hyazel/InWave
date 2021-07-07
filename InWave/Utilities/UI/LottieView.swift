//
//  LottieView.swift
//  InWave
//
//  Created by Laurent Droguet on 15/06/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let type: WaveAnimationType
    let animationSpeed: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(type.getAsset())
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = type.canLoop() ? .loop : .playOnce
        animationView.animationSpeed = animationSpeed
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
    }
}
