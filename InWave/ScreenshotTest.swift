//
//  ScreenshotTest.swift
//  InWave
//
//  Created by Laurent Droguet on 03/05/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI

struct ScreenshotTest: View {
    let height = UIScreen.main.bounds.size.height
    let hasSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0
    
    @State var test = false
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom))  {
            Color.Background.primary().ignoresSafeArea().gesture(DragGesture().onChanged({ value in
                print(value.location)
            }))
            
            GeometryReader { rect in
                HStack {
                    if test {
                    Capsule()
                        .frame(maxWidth: .infinity, maxHeight: 65)
                        .padding(.horizontal, 16)
                        .offset(y: 0.75 * rect.size.height - 65 - 12)
//                        .offset(y: -0.24*height - 16)/*-0.3*height + 60*/
                        .transition(.opacity)
                    }
                }
            }
        }// 0.68
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.test = true
            }
//            NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification,
//                                                   object: nil,
//                                                   queue: .main) { _ in
//
//            }
        }
    }
}

struct ScreenshotTest_Previews: PreviewProvider {
    static var previews: some View {
        ScreenshotTest()
    }
}
