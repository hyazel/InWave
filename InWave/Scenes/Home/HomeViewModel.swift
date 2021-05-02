//
//  HomeViewModel.swift
//  InWave
//
//  Created by Laurent Droguet on 06/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Core
import SwiftUI
import Combine
import Common

final class HomeViewModel: ObservableObject, Identifiable {
    // MARK: - Pulic properties
    @Published var breathCards: [BreathCellViewModel] = []
    @Published var totalSessionNumber: String = ""
    @Published var totalDailyTime: String = ""
    
    // MARK: - Private properties
    // Injected
    private let userRepository: UserRepositoryContract
    
    // Local
    private var breaths: [Breath] = []
    private var disposables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    init(dependencies: DependenciesContainer) {
        userRepository = dependencies.resolve()

        breathCards = getBestBreaths()
        
        Timer.scheduledTimer(withTimeInterval: 3600, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.breathCards = self.getBestBreaths()
        }
        
        userRepository.totalSessionNumberSubject
            .map { String($0) }
            .assign(to: \.totalSessionNumber, on: self)
            .store(in: &disposables)
        
        userRepository.totalDailyTimeSubject
            .map { [self] in formatTotalSessionNumber($0) }
            .assign(to: \.totalDailyTime, on: self)
            .store(in: &disposables)
    }
}

// MARK: - Inputs
extension HomeViewModel {
    func selectedBreath(index: Int) -> Breath {
        breaths[index]
    }
    
    func refresh() {
        self.breathCards = getBestBreaths()
    }
}

// MARK: - BreathCellViewModels
private extension HomeViewModel {
    func getBestBreaths() -> [BreathCellViewModel] {
        breaths = getBestBreath(for: Date())
        return breaths.map { BreathCellViewModel(iconName: $0.image,
                                                 title: $0.name,
                                                 subtitle: $0.description,
                                                 duration: "\(Int( $0.configuration.duration / 60)) min") }
        //        let journeys = getJourney(for: Date())
        //        breaths = journeys.map { $0.breath }
        //        return journeys.map {
        //            BreathCellViewModel(iconName: $0.breath.image,
        //                                title: $0.title,
        //                                subtitle: $0.description,
        //                                duration: "\(Int( $0.breath.configuration.duration / 60)) min")
        //        }
    }
}

// MARK: - Utilities
private extension HomeViewModel {
    func formatTotalSessionNumber(_ number: Int) -> String {
        let totalMinutes: Int = number / 60
        
        if totalMinutes < 1 {
            return "0"
        } else {
            return String(totalMinutes)
        }
    }
}

