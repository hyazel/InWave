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
                                               description: "Lutte contre le manque de souffle.",
                                               image: "buteyko",
                                               configuration: BreathConfiguration(inhale: 5,
                                                                                  inHaleHold: 5,
                                                                                  exhale: 5,
                                                                                  exhaleHold: 5,
                                                                                  cycleNumber: 15))
    
    public static var afghanWalk: Breath = Breath(name: Name.afghanWalk,
                                           description: "Marcher avec une oxygénation optimale.",
                                           image: "afghan_walk",
                                           configuration: BreathConfiguration(inhale: 3,
                                                                              inHaleHold: 1,
                                                                              exhale: 3,
                                                                              exhaleHold: 1,
                                                                              cycleNumber: 225))
    
    public static var square: Breath = Breath(name: Name.square,
                                       description: "Réduit le stress et améliore le bien être.",
                                       image: "squared",
                                       configuration: BreathConfiguration(inhale: 4,
                                                                          inHaleHold: 4,
                                                                          exhale: 4,
                                                                          exhaleHold: 4,
                                                                          cycleNumber: 20))
    
    public static var cardiacCoherence: Breath = Breath(name: Name.cardiacCoherence,
                                                 description: "Equilibre et régulation des émotions.",
                                                 image: "cardiac_coherence",
                                                 configuration: BreathConfiguration(inhale: 5,
                                                                                    inHaleHold: 0,
                                                                                    exhale: 5,
                                                                                    exhaleHold: 0,
                                                                                    cycleNumber: 30))
    
    public static var tonicCardiacCoherence: Breath = Breath(name: Name.tonicCardiacCoherence,
                                                      description: "Favorise le passage à l’action.",
                                                      image: "cardiac_coherence_tonic",
                                                      configuration: BreathConfiguration(inhale: 6,
                                                                                         inHaleHold: 0,
                                                                                         exhale: 4,
                                                                                         exhaleHold: 0,
                                                                                         cycleNumber: 30))
    
    public static var relaxCardiacCoherence: Breath = Breath(name: Name.relaxCardiacCoherence,
                                                      description: "Régénère le corps, calme et détente.",
                                                      image: "cardiac_coherence_relax",
                                                      configuration: BreathConfiguration(inhale: 4,
                                                                                         inHaleHold: 0,
                                                                                         exhale: 6,
                                                                                         exhaleHold: 0,
                                                                                         cycleNumber: 30))
    
    public static var forSevenEight: Breath = Breath(name: Name.forSevenEight,
                                              description: "Prépare l'endormissement.",
                                              image: "4_7_8",
                                              configuration: BreathConfiguration(inhale: 4,
                                                                                 inHaleHold: 7,
                                                                                 exhale: 8,
                                                                                 exhaleHold: 0,
                                                                                 cycleNumber: 10))
    
    public static func getBreathList() -> [Breath] {
        [
            Self.cardiacCoherence,
            Self.forSevenEight,
            Self.tonicCardiacCoherence,
            Self.square,
            Self.relaxCardiacCoherence,
            Self.afghanWalk,
//            Self.buteyko
        ]
    }
}

public func getBestBreath(for time: Date) -> [Breath] {
    let calendar = Calendar(identifier: Calendar.current.identifier)
    let hour = calendar.component(.hour, from: time)
    switch hour {
    case 0..<4:
        return [BreathList.forSevenEight, BreathList.relaxCardiacCoherence]
    case 4..<12:
        return [BreathList.tonicCardiacCoherence, BreathList.afghanWalk, BreathList.cardiacCoherence]
    case 12..<18:
        return [BreathList.cardiacCoherence, BreathList.square, BreathList.tonicCardiacCoherence]
    case 18..<20:
        return [BreathList.cardiacCoherence, BreathList.square, BreathList.relaxCardiacCoherence]
    case 20..<24:
        return [BreathList.forSevenEight, BreathList.relaxCardiacCoherence, BreathList.square]
    default:
        return [BreathList.cardiacCoherence]
    }
}
