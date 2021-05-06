//
//  CongratsView.swift
//  InWave
//
//  Created by Laurent Droguet on 19/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct CongratsView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(spacing: 36) {
            VStack(spacing: 24) {
                Image("reward")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                
                VStack(spacing: 8) {
                    Text("Exercice terminé !")
                        .font(Font.title1())
                        .foregroundColor(.black)
                    Text("Vos hormones de stress sont en chute et votre dopamine augmente.")
                        .font(Font.title3())
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
            }
            Button(action: { presentationMode.wrappedValue.dismiss() },
                   label: {
                    Text("OK")
                        .foregroundColor(.white)
                        .frame(width: 166, height: 54)
                        .background(Color.Palette.lagoon)
                        .cornerRadius(54)
                   }).shadow(color: Color.black.opacity(0.25), radius: 2, x: 0, y: 2)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(radius: 10)
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.2)
            
            CongratsView()
                .frame(width: 339, height: 400)
        }
    }
}
