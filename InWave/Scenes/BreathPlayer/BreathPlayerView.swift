//
//  BreathPlayerView.swift
//  InWave
//
//  Created by Laurent Droguet on 16/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Core

struct BreathPlayerView: View {
    @StateObject var viewModel: BreathViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var startAnimation: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            Color.Background.primary()
                .ignoresSafeArea(.all)
                .opacity(viewModel.viewState.hasFinished() ? 0.8 : 1)
            VStack {
                Spacer()
                ZStack {
//                    LottieView()
//                    Wave(firstCurveX: 0.4, secondCurveX: 0.55, yOffset: startAnimation ? 0.5 : -0.5)
//                        .fill(Color.Background.blue1())
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                        .animation(Animation
//                                    .easeInOut(duration: 0.5)
//                                    .repeat(while: viewModel.viewState.hasNotStarted(), autoreverses: true))
//
//                    Wave(firstCurveX: 0.2, secondCurveX: 0.75, yOffset: startAnimation ? 0.7 : -0.7)
//                        .fill(Color.Background.blue2())
//                        .frame(maxWidth: .infinity, maxHeight: 300)
//                        .animation(Animation
//                                    .easeInOut(duration: 0.6)
//                                    .repeat(while: viewModel.viewState.hasNotStarted(), autoreverses: true))
                }
                
            }
            .ignoresSafeArea()
            
            HStack {
                VStack {
                    Image(systemName: "xmark")
                        .frame(width: 46, height: 46)
                        .foregroundColor(.white)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                VStack {
                    Button {
                        viewModel.toogleMusic()
                    } label: {
                        Image(systemName: viewModel.isMusicPlaying ? "pause" : "play")
                            .frame(width: 46, height: 46)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            
            VStack {
                Text(viewModel.breathTitle)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, 12)
            
            GeometryReader { geometry in
                Text(viewModel.cycle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .offset(x: 0, y: geometry.size.height * 0.33 - 120)
            }
            
            switch viewModel.viewState {
            case .finished:
                CongratsView().padding(.horizontal, 24)
            case .notStarted:
                GeometryReader { geometry in
                    Text("Commencer")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 54)
                        .background(Color.orange)
                        .cornerRadius(54)
                        .padding(.horizontal, 53)
                        .offset(x: 0, y: geometry.size.height * 0.33)
                        .onTapGesture {
                            viewModel.viewState = .countdown
                        }
                }
            case .countdown:
                Text(viewModel.countdownTime).foregroundColor(.white).font(Font.headline1(.extraLarge))
            case .started:
                VStack {
                    GeometryReader { geometry in
                        HStack {
                            Text(viewModel.manoeuver).foregroundColor(.white).font(Font.headline1())
                            Text(viewModel.manoeuverTime).foregroundColor(.blue).font(Font.headline1())
                                .frame(width: 50)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.Palette.c4)
                        .overlay(
                                RoundedRectangle(cornerRadius: 60)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1)
                            )
                        .cornerRadius(60)
                        .padding(.horizontal, 80)
                        .offset(x: 0, y: geometry.size.height * 0.33)
                    }
                    
                    Spacer()
                    VStack(spacing: 56) {
                        VStack(spacing: 14) {
                            ProgressView(value: viewModel.currentNumber, total: 1)
                            HStack {
                                Text(viewModel.currentText).foregroundColor(.white)
                                Spacer()
                                Text(viewModel.totalTime).foregroundColor(.white)
                            }
                        }
                        Button(action: {
                            viewModel.tooglePlayer()
                        }, label: {
                            Image(viewModel.isPlaying ? "pause" : "settings")
                                .resizable()
                                .frame(width: 64, height: 64)
                        })
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            startAnimation = true
        }
    }
}

struct BreathPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        let breath = Breath(name: "Cohérence cardiaque",
                            description: "A long program to reach the calm",
                            image: "card",
                            configuration: BreathConfiguration(inhale: 4,
                                                               inHaleHold: 4,
                                                               exhale: 4,
                                                               exhaleHold: 4,
                                                               duration: 5))
        
        return BreathPlayerView(viewModel: BreathViewModel(breath: breath))
    }
}
