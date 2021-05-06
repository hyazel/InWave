//
//  SplashScreen.swift
//  InWave
//
//  Created by Laurent Droguet on 09/01/2021.
//

import SwiftUI
import DesignSystem

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            VStack {
                HStack {
                    Wave1()
                        .fill(Color.Palette.blueAccent).opacity(0.35)
                        .frame(width: 50, height: 500)
                    Spacer()
                }
                Spacer()
            }.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.blueAccent).opacity(0.35)
                        .frame(width: UIScreen.main.bounds.width - 50,
                               height: UIScreen.main.bounds.width - 50)
                        .offset(x: UIScreen.main.bounds.width - 100, y: -200)
                }
                Spacer()
            }.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Ellipse()
                        .fill(Color.Palette.blueAccent).opacity(0.35)
                        .frame(width: 300, height: 500)
                        .offset(x: 100, y: 400)
                }

            }.ignoresSafeArea()
            
            VStack(spacing: 32){
                Image("logo")
                Color.Divider.primary()
                    .frame(width: 24, height: 6)
                    .cornerRadius(12)
                VStack {
                    HStack(spacing: 8) {
                        Text("Respirez")
                            .foregroundColor(Color.Text.accent())
                            .font(Font.title1())
                        Text("pour")
                            .foregroundColor(.white)
                            .font(Font.title1())


                    }.padding(.horizontal, 43.0)
                    HStack(spacing: 8) {
                        Text("équilibrer")
                            .foregroundColor(Color.Text.accent())
                            .font(Font.title1())
                        Text("votre flot intérieur")
                            .foregroundColor(.white)
                            .font(Font.title1())


                    }
                }
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

struct Wave1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX + 100, y: 50),
                      control2: CGPoint(x: rect.maxX, y: 400) )
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()
        
        return path
    }
}
