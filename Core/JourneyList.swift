//
//  JourneyList.swift
//  Core
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

public struct JourneyList {
    
    static let wake = Journey(title: "Au réveil",
                              description: "Commencez la journée sur le bon pied",
                              breath: BreathList.cardiacCoherence)
    
    static let coffeeBreak = Journey(title: "Break café",
                                     description: "Un après midi concentré",
                                     breath: BreathList.tonicCardiacCoherence)
    static let sport = Journey(title: "Sport",
                               description: "vous prépare à vous endormir tout en douceur",
                               breath: BreathList.tonicCardiacCoherence)
    static let startEvening = Journey(title: "Soirée en douceur",
                                      description: "vous prépare à vous endormir tout en douceur",
                                      breath: BreathList.relaxCardiacCoherence)
    static let sleep = Journey(title: "Prêt à dormir",
                               description: "vous prépare à vous endormir tout en douceur",
                               breath: BreathList.forSevenEight)
}

public func getJourney(for time: Date) -> [Journey] {
    let calendar = Calendar(identifier: Calendar.current.identifier)
    let hour = calendar.component(.hour, from: time)
    switch hour {
    case 4...12:
        return [JourneyList.wake]
    case 13...18:
        return [JourneyList.coffeeBreak]
    case 18...22:
        return [JourneyList.startEvening, JourneyList.sport]
    case 20...24:
        return [JourneyList.sleep]
    case 0...4:
        return [JourneyList.sleep]
    default:
        return [JourneyList.coffeeBreak]
    }
}
