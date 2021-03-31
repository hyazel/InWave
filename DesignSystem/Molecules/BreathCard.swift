//
//  BreathCard.swift
//  InWave
//
//  Created by Laurent Droguet on 11/01/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

public struct BreathCard: View {
    private let imageName: String
    private let title: String
    private let subtitle: String
    private let duration: String
    
    public init(imageName: String, title: String, subtitle: String, duration: String) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
    }
    
    public var body: some View {
        ZStack {
            VStack() {
                Image(imageName)
                    .resizable()
                    .frame(width: 92, height: 92)
                    .clipShape(Circle())
                    .padding(.top, 24)
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text(title).font(Font.paragraph2())
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text(subtitle).font(Font.paragraph5()).foregroundColor(.black).lineLimit(10).multilineTextAlignment(.center)
                    }
                    Text(duration).font(Font.paragraph4()).foregroundColor(Color.Palette.gray1)
                }.padding([.trailing, .leading, .bottom], 18)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(24)
        }
        .frame(width: 182, height: 234)
    }
}

struct BreathCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().edgesIgnoringSafeArea(.all)
            BreathCard(imageName: "test1",
                       title: "Marche Afghane",
                       subtitle: "Marche Afghane, to reach the calm.",
                       duration: "30 MIN")
        }
    }
}
