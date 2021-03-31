//
//  DependenciesContainer.swift
//  PodcastersAnalytics
//
//  Created by Laurent Droguet on 16/03/2021.
//  Copyright © 2021 Deezer SA. All rights reserved.
//

import Foundation

/// Tiny dependencies container
/// It's static so every dependencies will remain in memory
open class DependenciesContainer {
    public init() {}

    private var dependencies: [DependencyKey: Any] = [:]

    /// Register a value by its type and a name (to differentiate values with the same type)
    public func register<T>(dependencyType: T.Type, dependencyValue: Any, name: String? = nil) {
        let dependencyKey = DependencyKey(type: dependencyType, name: name)
        dependencies[dependencyKey] = dependencyValue
    }

    /// Get a value registered with an optional name, if not only the type will be used
    public func resolve<T>(name: String? = nil) -> T {
        let dependencyKey = DependencyKey(type: T.self, name: name)
        guard let value = dependencies[dependencyKey] as? T else {
            fatalError()
        }
        return value
    }
}

final class DependencyKey: Hashable, Equatable {
    private let type: Any.Type
    private let name: String?

    init(type: Any.Type, name: String? = nil) {
        self.type = type
        self.name = name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(type))
        hasher.combine(name)
    }

    static func == (lhs: DependencyKey, rhs: DependencyKey) -> Bool {
        return lhs.type == rhs.type && lhs.name == rhs.name
    }
}
