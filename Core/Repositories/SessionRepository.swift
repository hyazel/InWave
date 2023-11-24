//
//  SessionRepository.swift
//  Core
//
//  Created by Laurent Droguet on 23/11/2023.
//  Copyright © 2023 InWave . All rights reserved.
//

import Foundation

struct RecordedSession: Codable {
    let date: Date
    let breath: Breath
}


final class SessionRepository {
    @ObjectUserDefault(StorageKeys.recordedSessions, defaultValue: [])
    public var recordedSessions: [RecordedSession]
    
    init() { }
    
    func record(breath: Breath) {
        if recordedSessions.count >= 31 {
            recordedSessions.removeFirst()
        }
        recordedSessions.append(RecordedSession(date: Date(), breath: breath))
    }
    
    func calculateNumberInARow(date: Date, numberInARow: Int) -> Int {
        guard let lastSessionDate = recordedSessions.last?.date else { return 1 }
        
        let twentyFourHoursInSeconds: TimeInterval = 24 * 60 * 60
        if date.timeIntervalSince(lastSessionDate) < twentyFourHoursInSeconds {
            return numberInARow + 1
        } else {
            return 1
        }
    }
}
