//
//  RootViewModel.swift
//  InWave
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Core
import Common

final class RootViewModel: ObservableObject, Identifiable {
    private var userRepository: UserRepositoryContract
    
    var onBoardingDone: Bool {
        userRepository.onBoardingDone
    }
    
    func setOnBoardingToDone() {
        userRepository.onBoardingDone = true
    }
    
    init(dependencies: DependenciesContainer) {
        userRepository = dependencies.resolve()
    }
}
