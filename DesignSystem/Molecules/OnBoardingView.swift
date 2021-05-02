//
//  onBoardingView.swift
//  InWave
//
//  Created by Laurent Droguet on 25/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct OnBoardingView: View {
    private let title: String
    private let icon: String
    
    public init(title: String, icon: String) {
        self.title = title
        self.icon = icon
    }
    
    public var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .frame(width: 180, height: 180, alignment: .center)
                .clipShape(Circle())
            Text(title)
                .font(Font.title1())
                .foregroundColor(.white).multilineTextAlignment(.leading)
        }
    }
}

struct onBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary()
            OnBoardingView(title: "bla", icon: "interested_face")
        }.edgesIgnoringSafeArea(.all)
    }
}
