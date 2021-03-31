//
//  Modifier.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 25/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.title).foregroundColor(.white)
    }
}


