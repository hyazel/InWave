//
//  HomeTimeView.swift
//  InWave
//
//  Created by Laurent Droguet on 11/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct HomeTimeView: View {
    @Binding var time: String
    
    public init(time: Binding<String>) {
        self._time = time
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Il est :")
                .font(Font.paragraph1())
                .foregroundColor(.white)
            Text(time)
                .font(Font.headline1(.extraLarge))
                .foregroundColor(.white)
        }
    }
}

struct HomeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().edgesIgnoringSafeArea(.all)
            HomeTimeView(time: .constant("13:06"))
        }
    }
}
