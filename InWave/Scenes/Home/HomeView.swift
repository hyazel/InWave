//
//  HomeView.swift
//  InWave
//
//  Created by Laurent Droguet on 29/11/2020.
//

import SwiftUI
import DesignSystem
import Core
import Common

struct HomeView: View {
    // MARK: - Constants
    enum Sizes {
        static func topInset(hasNotch: Bool) -> CGFloat {
            hasNotch ? 24 : 60
        }
    }
    enum Texts {
        static var listTitle: String = "Suggestions d'activités :"
    }
    
    // MARK: - Injected
    @StateObject var viewModel: HomeViewModel
    @ObservedObject var viewModelTimer: HomeViewModelTimer
    
    // MARK: - States
    @State private var selectedBreath: Breath?
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 48.0) {
                    StatsView(leadingText: viewModel.totalSessionNumber,
                              trailingText: viewModel.totalDailyTime)
                        .padding(.horizontal, 16)
                    
                    HomeTimeView(time: $viewModelTimer.time)
                        .padding(.horizontal, 16)
                    
                    carousel()
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.bottom, 16)
            .padding(.top, Sizes.topInset(hasNotch: UIApplication.screenHasNotch))
        }
    }
    
    // MARK: - Subviews
    fileprivate func carousel() -> some View {
        return VStack(alignment: .leading, spacing: 24) {
            Text(Texts.listTitle)
                .foregroundColor(Color.Text.primary())
                .font(Font.title2())
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 16)
                    HStack(spacing: 30) {
                        ForEach(Array(viewModel.breathCards.enumerated()), id: \.element.id) { (index, model) in
                            Button(action: {
                                self.selectedBreath = viewModel.selectedBreath(index: index)
                                self.isPresented = true
                            }, label: {
                                BreathCard(imageName: model.iconName,
                                           title: model.title,
                                           subtitle: model.subtitle,
                                           duration: model.duration)
                                    .frame(width: 188, height: 248)
                            })
                            .buttonStyle(PressableButtonStyle())
                        }
                    }
                }
            }
            .fullScreenCover(item: $selectedBreath) { breath in
                BreathPlayerView(viewModel: BreathViewModel(breath: breath))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            HomeView(viewModel: HomeViewModel(dependencies: AppDependencies.container),
                     viewModelTimer: HomeViewModelTimer())
        }
        
    }
}
