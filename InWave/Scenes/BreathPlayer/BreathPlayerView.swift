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
    @StateObject var viewModel: BreathViewModel
    @Environment(\.presentationMode) private var presentationMode
    @State private var startAnimation: Bool = false
    @State private var strokeWidth: Double = 12
    
    @State var test = false
    
    @State var countDownPlayer: AVAudioPlayer!
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            Color
                .Background.primary()
                .ignoresSafeArea(.all)
                .opacity(viewModel.viewState.hasFinished() ? 0.8 : 1)
            
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
//            .padding(.top, 14)
            
            
            Text(viewModel.cycle)
                .font(Font.detail())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .offset(y: -180)
            
            if startAnimation {
                HStack {
                    Spacer()
                    Image("island_big")
                }
                .offset(y: 100)
            }
            
            BreathSymbolsView(indexAvailable: viewModel.breathSymbolIndexAvailable,
                              indexHighlighted: $viewModel.breathSymbolIndex)
                .offset(x: 0, y: -130)
            
            switch viewModel.viewState {
            case .notStarted:
                ZStack {
                    if startAnimation {
                    LottieView(type: .idleLow,
                               animationSpeed: viewModel.waveAnimation.1)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .ignoresSafeArea()
                    }
                    Button {
                        viewModel.viewState = .countdown
                    } label: {
                        Text("Commencer")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: 54)
                            .background(Color.orange)
                            .cornerRadius(54)
                            .shadow(color: Color.black.opacity(0.15), radius: 12.0, x: 0, y: 0)
                    }
                    .padding(.horizontal, 53)
                    .offset(y: 50)
                }
            case .countdown:
                ZStack {
                    LottieView(type: .idleLow,
                               animationSpeed: viewModel.waveAnimation.1)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .ignoresSafeArea()
                    Text(viewModel.countdownTime)
                        .font(Font.headline1())
                        .foregroundColor(.white)
                }
            case .started, .finished:
                ZStack {
                    VStack {
                        Spacer()
                        switch viewModel.waveAnimation.0 {
                        case .idleLow:
                            LottieView(type: viewModel.waveAnimation.0,
                                       animationSpeed: viewModel.waveAnimation.1)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .ignoresSafeArea()
                        case .rise:
                            LottieView(type: viewModel.waveAnimation.0,
                                       animationSpeed: viewModel.waveAnimation.1)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .ignoresSafeArea()
                        case .fall:
                            LottieView(type: viewModel.waveAnimation.0,
                                       animationSpeed: viewModel.waveAnimation.1)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .ignoresSafeArea()
                        case .idleHigh:
                            LottieView(type: viewModel.waveAnimation.0,
                                       animationSpeed: viewModel.waveAnimation.1)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .ignoresSafeArea()
                        }
                    }
                    
                    HStack {
                        Text(viewModel.manoeuver)
                            .font(Font.headline2())
                            .foregroundColor(.white)
                        Text(viewModel.manoeuverTime)
                            .font(Font.headline2())
                            .foregroundColor(.white)
                    }
                    .offset(y: 100)
                    
                    // MARK: - Player
                    VStack {
                        Spacer()
                        VStack(spacing: 56) {
                            VStack(spacing: 14) {
                                ProgressView(value: viewModel.currentNumber, total: 1)
                                HStack {
                                    Text(viewModel.currentText)
                                        .font(Font.title3())
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(viewModel.totalTime)
                                        .font(Font.title3())
                                        .foregroundColor(.white)
                                }
                            }
                            Button(action: {
                                viewModel.tooglePlayer()
                            }, label: {
                                Image(viewModel.isPlaying ? "pause" : "play")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                            })
                        }
                        .padding()
                    }
                }
                
                
            }
            
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
            
            HStack {
                Spacer()
                VStack {
                    Button {
                        viewModel.toogleMusic()
                    } label: {
                        Image(viewModel.isMusicPlaying ? "speaker_on" : "speaker_off")
                            .resizable()
                            .frame(width: 30, height: 30)
                            
                    }
                    .frame(width: 46, height: 46)
                    .shadow(color: Color.black.opacity(0.15), radius: 2.0, x: 0, y: 2)
                    .padding(.trailing, 10)
                    Spacer()
                }
            }
            
            if viewModel.viewState.hasFinished() {
                CongratsView()
                    .transition(AnyTransition.scale.animation(Animation.easeIn(duration: 0.2)))
                    .padding(.horizontal, 18)
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
                                                               cycleNumber: 30))
        
        return BreathPlayerView(viewModel: BreathViewModel(breath: breath))
    }
}

/// An animatable modifier that is used for observing animations for a given animatable value.
struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }
    
    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value
    
    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void
    
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        
        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }
    
    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}

extension View {
    
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}

struct ReversingScale: AnimatableModifier {
    var value: CGFloat
    
    private var target: CGFloat
    private var onEnded: () -> ()
    
    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }
    
    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            // newValue here is interpolating by engine, so changing
            // from previous to initially set, so when they got equal
            // animation ended
            if newValue == target {
                onEnded()
            }
        }
    }
    
    func body(content: Content) -> some View {
        content.overlay(RoundedRectangle(cornerRadius: 60)
                            .strokeBorder(Color.white.opacity(0.5), lineWidth: value)
        )
    }
}
