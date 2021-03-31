//
//  URLExtensions.swift
//  InWave
//
//  Created by Laurent Droguet on 08/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import Foundation

public extension URL {
    /// Non-optional initializer with better fail output
    init(safeString string: String) {
        guard let instance = URL(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            fatalError("Unconstructable URL: \(string)")
        }
        self = instance
    }
}
