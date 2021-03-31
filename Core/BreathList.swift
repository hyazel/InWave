//
//  BreathList.swift
//  Core
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

public struct BreathList {
    struct Name {
        static let buteyko: String = "Buteyko"
        static let afghanWalk: String = "Marche Afghane"
        static let square: String = "Carrée"
        static let cardiacCoherence: String = "Cohérence Cardiaque"
        static let relaxCardiacCoherence: String = "Respiration relaxante"
        static let tonicCardiacCoherence: String = "Respiration tonique"
        static let forSevenEight: String = "4-7-8"
    }
    
    public static var buteyko: Breath = Breath(name: Name.buteyko,
                                               description: "Lutte contre le manque de souffle",
                                               image: "test1",
                                               configuration: BreathConfiguration(inhale: 2,
                                                                                  inHaleHold: 0,
                                                                                  exhale: 5,
                                                                                  exhaleHold: 5,
                                                                                  duration: 20))
    
    static var afghanWalk: Breath = Breath(name: Name.afghanWalk,
                                           description: "Marcher en respirant",
                                           image: "test1",
                                           configuration: BreathConfiguration(inhale: 2,
                                                                              inHaleHold: 0,
                                                                              exhale: 5,
                                                                              exhaleHold: 5,
                                                                              duration: 60 * 30))
    
    static var square: Breath = Breath(name: Name.square,
                                       description: "Réduit le stress et améliore le bien être",
                                       image: "test1",
                                       configuration: BreathConfiguration(inhale: 4,
                                                                          inHaleHold: 4,
                                                                          exhale: 4,
                                                                          exhaleHold: 4,
                                                                          duration: 60 * 5))
    
    static var cardiacCoherence: Breath = Breath(name: Name.cardiacCoherence,
                                                 description: "Equilibre et harmonie",
                                                 image: "test1",
                                                 configuration: BreathConfiguration(inhale: 5,
                                                                                    inHaleHold: 0,
                                                                                    exhale: 5,
                                                                                    exhaleHold: 0,
                                                                                    duration: 12))
    
    static var tonicCardiacCoherence: Breath = Breath(name: Name.tonicCardiacCoherence,
                                                      description: "Plus de tonus",
                                                      image: "test1",
                                                      configuration: BreathConfiguration(inhale: 6,
                                                                                         inHaleHold: 0,
                                                                                         exhale: 4,
                                                                                         exhaleHold: 0,
                                                                                         duration: 60 * 5))
    
    static var relaxCardiacCoherence: Breath = Breath(name: Name.relaxCardiacCoherence,
                                                      description: "Relaxez vous",
                                                      image: "test1",
                                                      configuration: BreathConfiguration(inhale: 4,
                                                                                         inHaleHold: 0,
                                                                                         exhale: 6,
                                                                                         exhaleHold: 5,
                                                                                         duration: 60 * 5))
    
    static var forSevenEight: Breath = Breath(name: Name.forSevenEight,
                                              description: "A long program to reach the calm",
                                              image: "test1",
                                              configuration: BreathConfiguration(inhale: 4,
                                                                                 inHaleHold: 7,
                                                                                 exhale: 8,
                                                                                 exhaleHold: 0,
                                                                                 duration: 60 * 1))
    
    public static func getBreathList() -> [Breath] {
        [
            Self.cardiacCoherence,
            Self.square,
            Self.tonicCardiacCoherence,
            Self.relaxCardiacCoherence,
            Self.forSevenEight,
            Self.afghanWalk,
            Self.buteyko
        ]
    }
}

public func getBestBreath(for time: Date) -> [Breath] {
    let calendar = Calendar(identifier: Calendar.current.identifier)
    let hour = calendar.component(.hour, from: time)
    switch hour {
    case 0...4:
        return [BreathList.forSevenEight, BreathList.relaxCardiacCoherence]
    case 4...12:
        return [BreathList.tonicCardiacCoherence, BreathList.afghanWalk]
    case 12...18:
        return [BreathList.cardiacCoherence, BreathList.square, BreathList.tonicCardiacCoherence]
    case 18...20:
        return [BreathList.square, BreathList.relaxCardiacCoherence]
    case 20...24:
        return [BreathList.forSevenEight, BreathList.relaxCardiacCoherence]
    default:
        return [BreathList.cardiacCoherence]
    }
}
