//
//  HomeView.swift
//  InWave
//
//  Created by Laurent Droguet on 29/11/2020.
//

import SwiftUI
import DesignSystem
import Core

struct HomeView: View {
    // MARK: - Injected
    @StateObject var viewModel: HomeViewModel
    @ObservedObject var viewModelTimer: HomeViewModelTimer
    
    // MARK: - States
    @State private var selectedBreath: Breath?
    @State private var isPresented: Bool = false
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 48.0) {
                    StatsView(leadingText: viewModel.totalSessionNumber, trailingText: viewModel.totalDailyTime)
                        .padding(.horizontal, 16)

                    
                    HomeTimeView(time: $viewModelTimer.time)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Suggestions d'activités :")
                            .foregroundColor(.white)
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
                                                .frame(width: 182, height: 240)
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
                    Spacer()
                }
                Spacer()
            }
//            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .padding(.top, 48)
//                     UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 24 : 0)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            viewModel.refresh()
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
