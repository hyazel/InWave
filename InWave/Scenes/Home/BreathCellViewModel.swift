//
//  BreathCellViewModel.swift
//  InWave
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

struct BreathCellViewModel: Identifiable {
    var id = UUID()
    
    let iconName: String
    let title: String
    let subtitle: String
    let duration: String
}
