//
//  CongratsView.swift
//  InWave
//
//  Created by Laurent Droguet on 19/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import DesignSystem

struct CongratsView: View {
    // MARK: - Constants
    enum Texts {
        static var title: String = "Exercice terminé !"
        static var text: String = "Vos hormones de stress sont en chute et votre dopamine augmente."
    }
    
    // MARK: - Environment
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(spacing: 36) {
            VStack(spacing: 24) {
                Image("reward")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                
                VStack(spacing: 8) {
                    Text(Texts.title)
                        .font(Font.title1())
                        .foregroundColor(Color.Text.secondary())
                    Text(Texts.text)
                        .font(Font.title3())
                        .foregroundColor(Color.Text.secondary())
                        .multilineTextAlignment(.center)
                }
            }
            SecondaryButton(title: "OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(24)
        .background(Color.Background.card())
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
