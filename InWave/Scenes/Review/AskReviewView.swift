//
//  AskReviewView.swift
//  InWave
//
//  Created by Laurent Droguet on 22/10/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import DesignSystem

struct AskReviewView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 36) {
                Capsule()
                    .fill(Color.Icon.selected())
                    .frame(width: 60, height: 8)
                    .padding(.top, 16)
                Image("happy_face")
                    .resizable()
                    .frame(width: 100,
                           height: 100)
                    .clipShape(Circle())
                VStack(spacing: 16) {
                    Text("Vous aimez bien notre app ?")
                        .font(Font.title1()).foregroundColor(.white)
                }
                HStack {
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Plus tard").frame(width: 166, height: 60).foregroundColor(.black)
                    })
                    Spacer()
                    SecondaryButton(title: "Yes") {}
                    Spacer()
                }
                Spacer()
            }
        }
        .background(Color.Background.primary())
        .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 24))
    }
}

struct AskReviewView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AskReviewView()
                .frame(maxWidth: .infinity, maxHeight: 340)
                
                
        }
        .ignoresSafeArea()
    }
}


struct CustomCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
