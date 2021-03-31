//
//  ActivityView.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 29/11/2020.
//

import SwiftUI

public struct ActivityView: View {
    public init() {}
    
    public var body: some View {
        HStack {
            VStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Aller dormir")
                        .foregroundColor(Color.white).bold()
                        
                    Text("Prépare votre système")
                        .font(.footnote)
                        .foregroundColor(Color.white)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.all, 16)
        .background(Color.Palette.c6)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
