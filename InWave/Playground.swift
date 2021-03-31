//
//  Playground.swift
//  InWave
//
//  Created by Laurent Droguet on 12/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Lottie

struct Playground: View {
    
    var body: some View {
        ZStack {
            LottieView()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
        }
    }
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}

 
struct LottieView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named("1_idle_low")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFill
        animationView.play()
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        
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
