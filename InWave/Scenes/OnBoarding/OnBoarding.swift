//
//  onBoarding.swift
//  InWave
//
//  Created by Laurent Droguet on 25/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Core
import DesignSystem

// MARK: - Main View
struct OnBoarding: View {
    enum Texts {
        static var page1 = "La vie moderne déséquilibre notre système nerveux"
        static var page2 = "La respiration permet de rééquilibrer ce système"
        static var page3 = "Les bénéfices sont nombreux : mieux dormir, digérer, mémoire ..."
        static var startButton = "COMMENCER"
    }
    
    @State var selectedTab: Int = 0
    var onBoadingHasFinished: (() -> Void)
    
    var body: some View {
        BaseView() {
            BackgroundWaves()
            onBoardingTabView()
            startButton()
        }
    }
    
    // MARK: - SubViews
    private func onBoardingTabView() -> some View {
        TabView(selection: $selectedTab,
                content:  {
                    OnBoardingView(title: Texts.page1,
                                   icon: "worried_face")
                        .tag(0)
                        .padding([.leading, .trailing], 36)
                    OnBoardingView(title: Texts.page2,
                                   icon: "interested_face")
                        .tag(1)
                        .padding([.leading, .trailing], 36)
                    OnBoardingView(title: Texts.page3,
                                   icon: "happy_face")
                        .tag(2)
                        .padding([.leading, .trailing], 36)
                })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
    
    private func startButton() -> some View {
        VStack {
            Spacer()
            Button {
                onBoadingHasFinished()
            } label: {
                Text(Texts.startButton)
            }
            .buttonStyle(SecondaryButtonStyle())
            .frame(width: 158, height: 54)
            .padding(.bottom, 64)
            .offset(y: selectedTab == 2 ? 0 : 200)
            .animation(Animations.spring)
        }
    }
}

struct onBoarding_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoarding() {}.previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            OnBoarding() {}.previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
