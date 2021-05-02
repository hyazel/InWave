//
//  StatsView.swift
//  InWave
//
//  Created by Laurent Droguet on 26/11/2020.
//

import SwiftUI

public struct StatsView: View {
    let leadingText: String
    let trailingText: String
    
    public init(leadingText: String, trailingText: String) {
        self.leadingText = leadingText
        self.trailingText = trailingText
    }
    
    public var body: some View {
        
        HStack {
            VStack(spacing: 8) {
                Text(leadingText)
                    .font(Font.title1())
                    .foregroundColor(.white)
                Text("SESSIONS")
                    .font(Font.detail())
                    .foregroundColor(.white)
            }
            Spacer()
            HStack(spacing: 24) {
                Divider()
                    .frame(width: 1.0, height: 30.0)
                    .background(Color.Divider.primary())
                
                VStack(spacing: 8) {
                    Text(trailingText)
                        .font(Font.title1())
                        .foregroundColor(.white)
                    Text("MINUTES")
                        .font(Font.detail())
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().edgesIgnoringSafeArea(.all)
            StatsView(leadingText: "14", trailingText: "35")
        }
    }
}
