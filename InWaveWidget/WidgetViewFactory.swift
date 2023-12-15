//
//  WidgetViewFactory.swift
//  InWave
//
//  Created by Laurent Droguet on 13/12/2023.
//  Copyright © 2023 InWave . All rights reserved.
//

import SwiftUI

struct WidgetViewFactory: View {
    
    var body: some View {
        ZStack {
            smallWidgetView()
        }
    }
    
    func smallWidgetView() -> some View {
        breathView(image: "cardiac_coherence", title: "cohérence cardiaque")
    }
    
    func mediumWidgetView() -> some View {
        HStack(spacing: 32) {
            breathView(image: "cardiac_coherence", title: "cohérence cardiaque")
            breathView(image: "cardiac_coherence", title: "sommeil")
        }
    }
    
    func breathView(image: String, title: String) -> some View {
        Link(destination: URL(safeString: "www.inwave.com/breath/\(title)")) {
            VStack(spacing: 0) {
                Image(image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                    .shadow(radius: 10)
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.title3())
                    .foregroundColor(.black)
                    .frame(height: 35, alignment: .top)
            }
            .frame(width: 96)
        }
    }
}

#Preview {
    ZStack {
        WidgetViewFactory()
            .frame(width: 150, height: 150)
            .background(LinearGradient(gradient: Gradient(colors: [Color.Palette.pearl, Color.Palette.pearl]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea())
            .cornerRadius(8)
    }
}
