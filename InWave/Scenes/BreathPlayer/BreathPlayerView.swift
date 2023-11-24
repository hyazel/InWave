//
//  BreathPlayerView.swift
//  InWave
//
//  Created by Laurent Droguet on 16/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Core
import DesignSystem
import AVKit

struct BreathPlayerView: View {
    enum Texts {
        static var sessionStartButton: String = "COMMENCER LA SESSION"
    }
    
    @State var hasFinished: Bool = false
    
    // MARK: - States
    @StateObject var viewModel: BreathViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var onAppear: Bool = false
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        BaseView {
            
            // MARK: - Background
            if onAppear {
                backgroundView().zIndex(0)
            }
            
            // MARK: - Header
            headerView().zIndex(1)
            
            // MARK: - Breath values
            Text(viewModel.cycleText)
                .font(Font.detail())
                .foregroundColor(Color.Text.primary())
                .frame(maxWidth: .infinity)
                .offset(y: -200)
                .zIndex(1)

            BreathSymbolsView(indexAvailable: viewModel.breathSymbolIndexAvailable,
                              indexHighlighted: $viewModel.breathSymbolIndex)
                .offset(x: 0, y: -150)
                .zIndex(1)
            
            if viewModel.viewStep.hasFinished() {
                Color.black.opacity(0.4).ignoresSafeArea()
            }
            
            // MARK: - Process exercice steps
            switch viewModel.viewStep {
            case .notStarted:
                ZStack {
                    PrimaryButton(title: Texts.sessionStartButton) {
                        viewModel.viewStep = .countdown
                    }
                    .frame(maxWidth: .infinity, maxHeight: 54)
                    .padding(.horizontal, 53)
                    .offset(y: 50)
                }
                .zIndex(1)
            case .countdown:
                Text(viewModel.countdownText)
                    .font(Font.headline1())
                    .foregroundColor(Color.Text.primary())
                    .zIndex(1)
            case .started:
                ZStack {
                    HStack {
                        Text(viewModel.currentBreathAction)
                            .font(Font.headline2())
                            .foregroundColor(.white)
                        Text(viewModel.currentBreathActionTimeRemaining)
                            .font(Font.headline2())
                            .foregroundColor(.white)
                    }
                    .offset(y: 100)
                    
                    player()
                }
                .zIndex(1)
            case .finished:
                EmptyView()
            }
        }
        .sheet(isPresented: $hasFinished) {
            CongratsView(leadingText: viewModel.congratsText.totalDailyTime / 60,
                         trailingText: viewModel.congratsText.dailySessionNumberInARow) {
                presentationMode.wrappedValue.dismiss()
            }
            .presentationDragIndicator(.hidden)
            .presentationDetents([.height(340)])
            .interactiveDismissDisabled()
        }
        .onChange(of: viewModel.viewStep) {
            if $0.hasFinished() {
                hasFinished = true
            }
        }
        .onAppear {
            onAppear = true
        }
    }
    
    // MARK: -  Subviews
    private func headerView() -> some View {
        ZStack {
            // Icon and text
            VStack {
                Image(viewModel.breath.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                Text(viewModel.breathTitle)
                    .font(Font.title2())
                    .foregroundColor(.white)
                Spacer()
            }
            
            // Dismiss button
            HStack {
                VStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle().stroke(Color.white, lineWidth: 2)
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "xmark")
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: 46, height: 46)
                    .shadow(color: Color.black.opacity(0.15), radius: 2.0, x: 0, y: 2)
                    .padding(.leading, 10)
                    Spacer()
                }
                Spacer()
            }
            
            // Toogle music
            HStack {
                Spacer()
                VStack {
                    Button {
                        viewModel.toogleMusic()
                    } label: {
                        Image(viewModel.musicPlayerIsPlaying ? "speaker_on" : "speaker_off")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                    }
                    .frame(width: 46, height: 46)
                    .shadow(color: Color.black.opacity(0.15), radius: 2.0, x: 0, y: 2)
                    .padding(.trailing, 10)
                    Spacer()
                }
            }
        }
    }
    
    private func backgroundView() -> some View {
        ZStack {
            // Big island
            HStack {
                Spacer()
                Image("island_big")
            }
            .offset(y: 100)
            
            // Lottie
            switch viewModel.waveAnimation.0 {
            case .idleLow:
                WaveLottieView(type: viewModel.waveAnimation.0,
                           animationSpeed: viewModel.waveAnimation.1)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .ignoresSafeArea()
            case .rise:
                WaveLottieView(type: viewModel.waveAnimation.0,
                           animationSpeed: viewModel.waveAnimation.1)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .ignoresSafeArea()
            case .fall:
                WaveLottieView(type: viewModel.waveAnimation.0,
                           animationSpeed: viewModel.waveAnimation.1)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .ignoresSafeArea()
            case .idleHigh:
                WaveLottieView(type: viewModel.waveAnimation.0,
                           animationSpeed: viewModel.waveAnimation.1)
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .ignoresSafeArea()
            }
        }
    }
    
    private func player() -> some View {
            VStack {
                Spacer()
                VStack(spacing: 56) {
                    VStack(spacing: 14) {
                        ProgressView(value: viewModel.breathTimeProgressValue, total: 1)
                        HStack {
                            Text(viewModel.breathTimeProgressText)
                                .font(Font.title3())
                                .foregroundColor(.white)
                            Spacer()
                            Text(viewModel.breathTotalDurationText)
                                .font(Font.title3())
                                .foregroundColor(.white)
                        }
                    }
                    Button(action: {
                        viewModel.tooglePlayer()
                    }, label: {
                        Image(viewModel.breathPlayerIsPlaying ? "pause" : "play")
                            .resizable()
                            .frame(width: 64, height: 64)
                    })
                }
                .padding()
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
                                                               cycleNumber: 30))
        
        return BreathPlayerView(viewModel: BreathViewModel(breath: breath))
    }
}
