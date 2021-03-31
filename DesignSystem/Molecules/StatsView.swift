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
                Text(leadingText).font(Font.headline2()).foregroundColor(.white)
                Text("SESSIONS")
                    .font(Font.paragraph4())
                    .foregroundColor(.white)
            }
            Spacer()
            HStack(spacing: 24) {
                Divider()
                    .frame(width: 1.0, height: 30.0)
                    .background(Color(red: 0.518, green: 0.584, blue: 0.631))
                
                VStack(spacing: 8) {
                    Text(trailingText).font(Font.headline2()).foregroundColor(.white)
                    Text("MINUTES")
                        .font(Font.paragraph4())
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
