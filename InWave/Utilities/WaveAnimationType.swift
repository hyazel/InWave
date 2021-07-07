//
//  WaveAnimationType.swift
//  InWave
//
//  Created by Laurent Droguet on 15/06/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Core

enum WaveAnimationType {
    case idleLow
    case rise
    case idleHigh
    case fall
    
    func getAsset() -> String {
        switch self {
        case .idleLow:
            return "1_idle_low"
        case .rise:
            return "2_rise"
        case .idleHigh:
            return "3_idle_high"
        case .fall:
            return "4_fall"
        }
    }
    
    static func convert(from: ManoeuverType) -> WaveAnimationType {
        switch from {
        case .inhale:
            return .rise
        case .inHaleHold:
            return .idleHigh
        case .exhale:
            return .fall
        case .exhaleHold:
            return .idleLow
        }
    }
    
    func canLoop() -> Bool {
        switch self {
        case .idleHigh, .idleLow:
            return true
        default:
            return false
        }
    }
}
