//
//  Journey.swift
//  Core
//
//  Created by Laurent Droguet on 31/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

public struct Journey: Identifiable {
    public let id = UUID()
    public let title: String
    public let description: String
    public let breath: Breath
}
