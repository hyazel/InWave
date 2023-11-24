//
//  CongratsView.swift
//  InWave
//
//  Created by Laurent Droguet on 19/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import DesignSystem
import Lottie
import Core

struct CongratsView: View {
    // MARK: - Constants
    enum Texts {
        static var title: String = "Exercice terminé ✨"
        static var text: String = "\u{2022} Hormones de stress en chute \n\u{2022} Augmentation des hormones du bien être \n\u{2022} Meilleur défense immunitaire"
    }
    
    // MARK: - Environment
    var dismissed: (()->())? = nil
    
    private let userRepository = UserRepository()
    
    @State private var leadingText: Int
    @State private var trailingText: Int
    
    init(leadingText: Int, trailingText: Int, dismissed: (()->())? = nil) {
        self.leadingText = leadingText
        self.trailingText = trailingText
        self.dismissed = dismissed
    }
    
    var body: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            VStack(spacing: 0) {
                VStack {
                    Text(Texts.title)
                        .font(Font.title1())
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 12)
                    
                    WaveLottieView(type: .idleHigh,
                                   animationSpeed: 0.5)
                        
                    .clipShape(Circle())
                        .frame(width: 100,
                               height: 100)
                        .padding(.bottom, 12)
                    HStack(spacing: 32) {
                        VStack {
                            HStack(spacing: 2) {
                                Text("**\(leadingText)**")
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                self.leadingText = userRepository.totalDailyTime / 60
                                            }
                                        }
                                    }
                                    .contentTransition(.numericText())
                                Text("**min**")
                            }
                            Text("de pratique")
                        }
                        VStack {
                            Text("**\(trailingText)**")
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            self.trailingText = userRepository.dailySessionNumberInARow
                                        }
                                    }
                                }
                                .contentTransition(.numericText())
                            Text("sessions d'affilée")
                        }
                    }
                    .font(.body())
                    .padding(.bottom, 32)
                    .multilineTextAlignment(.center)
                }
                
                SecondaryButton(title: "OK", fixedWidth: false) {
                    dismissed?()
                }
            }
            .padding(.horizontal, 32)
        }
        .foregroundColor(.Palette.snow)
        .background()
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea().opacity(0.2)
        }
        .sheet(isPresented: .constant(true)) {
            CongratsView(leadingText: 74, trailingText: 3)
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(340)])
                .interactiveDismissDisabled()
        }
        .ignoresSafeArea()
    }
}
