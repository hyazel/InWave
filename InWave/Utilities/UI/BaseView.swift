//
//  BaseView.swift
//  InWave
//
//  Created by Laurent Droguet on 12/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct BaseView<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            content()
        }
    }
}
