//
//  BreathEngine.swift
//  Core
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

public enum ManoeuverType {
    case inhale
    case inHaleHold
    case exhale
    case exhaleHold
    
    public func getTitle() -> String {
        switch self {
        case .inhale:
            return "Inspirez"
        case .inHaleHold, .exhaleHold:
            return "Retenez"
        case .exhale:
            return "Expirez"
        }
    }
}

public final class BreathEngine {
    public var currentManoeuver: ManoeuverType = .inhale
    
    private let breath: Breath
    
    public init(breath: Breath) {
        self.breath = breath
    }
    
    public func nextManoeuver() {
        switch currentManoeuver {
        case .inhale:
            currentManoeuver = breath.configuration.inHaleHold == 0 ? .exhale : .inHaleHold
        case .inHaleHold:
            currentManoeuver = .exhale
        case .exhale:
            currentManoeuver = breath.configuration.exhaleHold == 0 ? .inhale : .exhaleHold
        case .exhaleHold:
            currentManoeuver = .inhale
        }
    }
    
    public func getCurrentManoeuverDuration() -> Int {
        switch currentManoeuver {
        case .inhale:
            return breath.configuration.inhale
        case .inHaleHold:
            return breath.configuration.inHaleHold
        case .exhale:
            return breath.configuration.exhale
        case .exhaleHold:
            return breath.configuration.exhaleHold
        }
    }
    
    public func getCurrentAudio() -> InWavePlayer.Audio {
        switch currentManoeuver {
        case .inhale:
            return .inhale(duration: breath.configuration.inhale)
        case .exhale:
            return .exhale(duration: breath.configuration.exhale)
        case .inHaleHold:
            return .hold(duration: breath.configuration.inHaleHold)
        case .exhaleHold:
            return .hold(duration: breath.configuration.exhaleHold)
        }
    }
}
