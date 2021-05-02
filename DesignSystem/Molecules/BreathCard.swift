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
    private let imageSize: CGSize
    
    public init(imageName: String, title: String, subtitle: String, duration: String, imageSize: CGSize = CGSize(width: 92, height: 92)) {
        self.imageName = imageName
        self.title = title
        self.subtitle = subtitle
        self.duration = duration
        self.imageSize = imageSize
    }
    
    public var body: some View {
        ZStack {
            VStack() {
                Image(imageName)
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .clipShape(Circle())
                VStack(spacing: 20) {
                    VStack(spacing: 6) {
                        Text(title)
                            .font(Font.detail())
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        Text(subtitle)
                            .font(Font.title3())
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(height: 35)
                    }
                    Text(duration)
                        .font(Font.detail())
                        .foregroundColor(Color.Palette.shell)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding([.trailing, .leading, .bottom], 12)
            .padding(.top, 24)
            .background(Color.white)
            .cornerRadius(24)
        }
    }
}

struct BreathCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().edgesIgnoringSafeArea(.all)
            HStack {
                BreathCard(imageName: "test1",
                           title: "Respiration Relaxante",
                           subtitle: "Marche Afghane, to reach the calm.",
                           duration: "30 MIN",
                           imageSize: CGSize(width: 92,
                                             height: 92))
                    .frame(width: 182, height: 234)
                
                BreathCard(imageName: "test1",
                           title: "Marche Afghane",
                           subtitle: "Marche Afghane",
                           duration: "30 MIN",
                           imageSize: CGSize(width: 92,
                                             height: 92))
                    .frame(width: 182, height: 234)
            }
        }
    }
}
