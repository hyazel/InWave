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
            Color.Background.primary().ignoresSafeArea()
            HStack {
                VStack(alignment: .leading, spacing: 48.0) {
                    StatsView(leadingText: viewModel.totalSessionNumber, trailingText: viewModel.totalDailyTime)
                    
                    HomeTimeView(time: $viewModelTimer.time)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Suggestions d'activités :")
                            .foregroundColor(.white)
                            .font(Font.paragraph1())
                        ScrollView(.horizontal) {
                            HStack(spacing: 30) {
                                ForEach(Array(viewModel.breathCards.enumerated()), id: \.element.id) { (index, model) in
                                    BreathCard(imageName: model.iconName,
                                               title: model.title,
                                               subtitle: model.subtitle,
                                               duration: model.duration)
                                        .onTapGesture {
                                            self.selectedBreath = viewModel.selectedBreath(index: index)
                                            self.isPresented = true
                                        }
                                }
                            }
                            .padding(30)
                        }
                        .fullScreenCover(item: $selectedBreath) { breath in
                            BreathPlayerView(viewModel: BreathViewModel(breath: breath))
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            viewModel.refresh()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HomeView(viewModel: HomeViewModel(dependencies: AppDependencies.container),
                     viewModelTimer: HomeViewModelTimer())
        }
        
    }
}
