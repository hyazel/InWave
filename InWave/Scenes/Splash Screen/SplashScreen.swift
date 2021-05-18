//
//  SplashScreen.swift
//  InWave
//
//  Created by Laurent Droguet on 09/01/2021.
//

import SwiftUI
import DesignSystem

struct SplashScreen: View {
    enum Texts {
        static var line1Leading = "Respirez"
        static var line1Trailing = "pour"
        static var line2Leading = "équilibrer"
        static var line2Trailing = "votre flot intérieur"
    }
    
    var body: some View {
        BaseView {
            BackgroundWaves()
            VStack(spacing: 32){
                Image("logo")
                Capsule()
                    .fill(Color.Divider.primary())
                    .frame(width: 24, height: 6)
                BreathText()
            }
            
        }
    }
    
    // MARK: - Subviews
    fileprivate func BreathText() -> some View {
        return VStack {
            HStack(spacing: 8) {
                Text(Texts.line1Leading)
                    .foregroundColor(Color.Text.accent())
                    .font(Font.title1())
                Text(Texts.line1Trailing)
                    .foregroundColor(Color.Text.primary())
                    .font(Font.title1())
            }
            .padding(.horizontal, 43.0)
            HStack(spacing: 8) {
                Text(Texts.line2Leading)
                    .foregroundColor(Color.Text.accent())
                    .font(Font.title1())
                Text(Texts.line2Leading)
                    .foregroundColor(Color.Text.primary())
                    .font(Font.title1())
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreen().previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            SplashScreen().previewDevice(PreviewDevice(rawValue: "iPhone Xr"))
            SplashScreen().previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
