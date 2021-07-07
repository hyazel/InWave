//
//  Breath.swift
//  Core
//
//  Created by Laurent Droguet on 13/11/2020.
//

import Foundation
import Combine

public struct BreathConfiguration {
    public let inhale: Int
    public let inHaleHold: Int
    public let exhale: Int
    public let exhaleHold: Int
    public var duration: Int
    public var cycleNumber: Int
    
    public init(inhale: Int, inHaleHold: Int, exhale: Int, exhaleHold: Int, cycleNumber: Int) {
        self.inhale = inhale
        self.inHaleHold = inHaleHold
        self.exhale = exhale
        self.exhaleHold = exhaleHold
        self.cycleNumber = cycleNumber
        duration = (inhale + inHaleHold + exhale + exhaleHold) * cycleNumber
    }
}

public struct Breath: Identifiable {
    public let id = UUID()
    public let name: String
    public let description: String
    public let image: String
    public var configuration: BreathConfiguration
    
    public init(name: String, description: String, image: String, configuration: BreathConfiguration) {
        self.name = name
        self.description = description
        self.image = image
        self.configuration = configuration
    }
}
