//
//  AppDependencies.swift
//  PodcastersAnalytics
//
//  Created by Laurent Droguet on 19/03/2021.
//  Copyright © 2021 Deezer SA. All rights reserved.
//

import Foundation
import Core
import Common

final class AppDependencies {
    static var container: DependenciesContainer = DependenciesContainer()
    
    static func make() {
        let dc = Self.container
        dc.register(dependencyType: UserRepositoryContract.self,
                    dependencyValue: UserRepository())
    }
}
