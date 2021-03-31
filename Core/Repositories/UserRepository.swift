//
//  UserRepository.swift
//  Core
//
//  Created by Laurent Droguet on 06/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation
import Combine

public protocol UserRepositoryContract {
    var totalSessionNumberSubject: CurrentValueSubject<Int, Never> { get }
    var totalDailyTimeSubject: CurrentValueSubject<Int, Never> { get }
    
    var totalSessionNumber: Int { get set }
    var totalDailyTime: Int { get set }
    var onBoardingDone: Bool { get set }
    var isMusicmuted: Bool { get set }
}

public final class UserRepository: UserRepositoryContract {
    public var totalSessionNumberSubject = CurrentValueSubject<Int, Never>(0)
    public var totalDailyTimeSubject = CurrentValueSubject<Int, Never>(0)
    
    @UserDefault(StorageKeys.onBoardingDone, defaultValue: false)
    public var onBoardingDone: Bool
    
    @UserDefault(StorageKeys.isMusicmuted, defaultValue: false)
    public var isMusicmuted: Bool
    
    @UserDefault(StorageKeys.totalSessionNumber, defaultValue: 0) public var totalSessionNumber: Int {
        didSet {
            totalSessionNumberSubject.send(totalSessionNumber)
        }
    }
    @UserDefault(StorageKeys.totalDailyTime, defaultValue: 0) public var totalDailyTime: Int {
        didSet {
            totalDailyTimeSubject.send(totalDailyTime)
        }
    }
    
    public init() {
        totalSessionNumberSubject.send(totalSessionNumber)
        totalDailyTimeSubject.send(totalDailyTime)
    }
}
