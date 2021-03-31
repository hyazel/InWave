//
//  NavigationLazyView.swift
//  InWave
//
//  Created by Laurent Droguet on 18/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
