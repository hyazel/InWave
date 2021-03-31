//
//  BreathListViewModel.swift
//  InWave
//
//  Created by Laurent Droguet on 10/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Core

final class BreathListViewModel: ObservableObject {
    
    let breathCellViewModels: [BreathCellViewModel]
    let breaths: [Breath]
    
    init() {
        breaths = BreathList.getBreathList()
        breathCellViewModels = breaths.map { BreathCellViewModel(iconName: $0.image,
                                                       title: $0.name,
                                                       subtitle: $0.description,
                                                       duration: "\(Int($0.configuration.duration / 60)) min") }
    }
    
    func selectedBreath(index: Int) -> Breath {
        breaths[index]
    }
}
