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

struct Playground: View {
    
    var body: some View {
        ZStack {
            
            WaveLottieView(type: .fall,
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
