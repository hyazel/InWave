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
                Image("card")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                
                VStack(spacing: 8) {
                    Text("Exercice terminé !")
                    Text("Vos hormones de stress sont en chute et votre dopamine augmente.")
                }
            }
            Button(action: { presentationMode.wrappedValue.dismiss() },
                   label: {
                    Text("OK")
                        .foregroundColor(.white)
                        .frame(width: 166, height: 54)
                        .background(Color.Palette.c1)
                        .cornerRadius(54)
                   })
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.2)
            CongratsView()
                .frame(width: 339, height: 342)
        }
    }
}
