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

struct OnBoarding: View {
    enum Texts {
        static var page1 = "La vie moderne déséquilibre notre système nerveux"
        static var page2 = "La respiration permet de rééquilibrer ce système"
        static var page3 = "Les bénéfices sont nombreux : mieux dormir, digérer, mémoire ..."
    }
    
    @State var selectedTab: Int = 0
    var onBoadingHasFinished: (() -> Void)
    
    var body: some View {
        ZStack {
            Color.Background.primary()
            
            VStack {
                HStack {
                    Wave1()
                        .fill(Color.Palette.blueAccent)
                        .opacity(0.35)
                        .frame(width: 50, height: 500)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.blueAccent).opacity(0.35)
                        .frame(width: 400, height: 500)
                        .rotationEffect(Angle(degrees: -30))
                        .offset(x: 320, y: -70)
                }
                Spacer()
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.blueAccent).opacity(0.35)
                        .frame(width: 400, height: 500)
                        .offset(x: 100, y: 400)
                }
                
            }.ignoresSafeArea()
            
            TabView(selection: $selectedTab,
                    content:  {
                        OnBoardingView(title: Texts.page1, icon: "worried_face")
                            .tag(0)
                            .padding([.leading, .trailing], 36)
                        OnBoardingView(title: Texts.page2, icon: "interested_face")
                            .tag(1)
                            .padding([.leading, .trailing], 36)
                        OnBoardingView(title: Texts.page3, icon: "happy_face")
                            .tag(2)
                            .padding([.leading, .trailing], 36)
                    })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            VStack {
                Spacer()
                Button {
                    onBoadingHasFinished()
                } label: {
                    Text("COMMENCER")
                }
                .frame(width: 158, height: 54)
                .foregroundColor(Color.white)
                .background(Color.Palette.lagoon)
                .cornerRadius(54)
                .padding(.bottom, 64)
                .offset(y: selectedTab == 2 ? 0 : 150)
                .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 10))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct onBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding() {}
    }
}
