//
//  BacASable.swift
//  InWave
//
//  Created by Laurent Droguet on 10/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import DesignSystem

struct BacASable: View {
    @State private var isEnabled = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.red)
                .frame(width: 100,
                       height: 100)
                .padding(.horizontal, 100)
                .background(Color.yellow)
        }
    }
}

struct BacASable_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BacASable()
        }
    }
}

