//
//  Playground.swift
//  InWave
//
//  Created by Laurent Droguet on 12/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Lottie
import Core

enum WaveAnimationType {
    case idleLow
    case rise
    case idleHigh
    case fall
    
    func getAsset() -> String {
        switch self {
        case .idleLow:
            return "1_idle_low"
        case .rise:
            return "2_rise"
        case .idleHigh:
            return "3_idle_high"
        case .fall:
            return "4_fall"
        }
    }
    
    static func convert(from: ManoeuverType) -> WaveAnimationType {
        switch from {
        case .inhale:
            return .rise
        case .inHaleHold:
            return .idleHigh
        case .exhale:
            return .fall
        case .exhaleHold:
            return .idleLow
        }
    }
    
    func canLoop() -> Bool {
        switch self {
        case .idleHigh, .idleLow:
            return true
        default:
            return false
        }
    }
}

struct Playground: View {
    
    var body: some View {
        ZStack {
            
            LottieView(type: .fall,
                       animationSpeed: 1)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}

 //  - 2_rise - 3_idle_high - 4_fall
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
