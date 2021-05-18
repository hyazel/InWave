//
//  StatsView.swift
//  InWave
//
//  Created by Laurent Droguet on 26/11/2020.
//

import SwiftUI

public struct StatsView: View {
    enum Texts {
        static var sessionNumber: String = "SESSIONS"
        static var sessionTime: String = "MINUTES"
    }
    
    let leadingText: String
    let trailingText: String
    
    public init(leadingText: String, trailingText: String) {
        self.leadingText = leadingText
        self.trailingText = trailingText
    }
    
    public var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(leadingText)
                    .font(Font.title1())
                    .foregroundColor(Color.Text.primary())
                Text(Texts.sessionNumber)
                    .font(Font.detail())
                    .foregroundColor(Color.Text.primary())
            }
            Spacer()
            HStack(spacing: 24) {
                Divider()
                    .frame(width: 1.0, height: 30.0)
                    .background(Color.Divider.primary())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(trailingText)
                        .font(Font.title1())
                        .foregroundColor(Color.Text.primary())
                    Text(Texts.sessionTime)
                        .font(Font.detail())
                        .foregroundColor(Color.Text.primary())
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
