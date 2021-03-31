//
//  StorageHelpers.swift
//  PodcastersAnalytics
//
//  Created by Laurent Droguet on 19/02/2020.
//  Copyright © 2020 Laurent Droguet. All rights reserved.
//

import Foundation

/// Get/Set data from some providers
protocol StorageProvider {
    func set(_ value: String, key: String)
    func get(key: String) -> String?
}

@propertyWrapper
/// PropertyWrapper to handle value from UserDefaults
public struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@propertyWrapper
/// PropertyWrapper to handle value from UserDefaults
public struct OptionnalUserDefaultObject<T: Codable> {
    let key: String
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    init(_ key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
            return try? decoder.decode(T.self, from: data)
        }
        set {
            let data = try? encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
