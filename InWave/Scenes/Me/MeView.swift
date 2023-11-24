//
//  MeView.swift
//  InWave
//
//  Created by Laurent Droguet on 20/10/2023.
//  Copyright © 2023 InWave . All rights reserved.
//

import SwiftUI
import Charts
import Core
import Charts

struct Value: Identifiable {
    var id = UUID()
    var category: String
    var value: Double
}

struct MeView: View {
    @StateObject var viewModel = MeViewModel()
    
    let data2 = [
        Value(category: "Jun 1", value: 0),
        Value(category: "Jun 2", value: 2),
        Value(category: "Jun 3", value: 0),
        Value(category: "Jun 4", value: 1),
        Value(category: "Jun 5", value: 0),
        Value(category: "Jun 6", value: 1),
        Value(category: "Jun 7", value: 0),
        Value(category: "Jun 8", value: 3)
    ]
    
    var body: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            VStack(spacing: 0) {
                WaveLottieView(type: .idleHigh, animationSpeed: 0.5)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.bottom, 48)
                
                Spacer()
                
                ZStack {
                    Color.Palette.darkOcean
                        .cornerRadius(24)
                        .shadow(radius: 12)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        HStack {
                            
                            VStack {
                                Text("**\(viewModel.sessionsInARow)**")
                                Text("sessions d'affilée")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                            
                            Spacer()
                            VStack {
                                Text("**\(viewModel.topSessionsInARow)**")
                                Text("mon top d'affilée")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                        }
                        .padding(.bottom, 12)
                        
                        HStack {
                            VStack {
                                Text("**\(viewModel.sessionNumber)**")
                                Text("sessions")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                            Spacer()
                            VStack {
                                Text("**\(viewModel.sessionNumberTime) min**")
                                Text("de pratique")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                        }
                        
                        HStack {
                            VStack {
                                Text("**\(viewModel.sessionNumber)**")
                                Text("sessions")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                            Spacer()
                            VStack {
                                Text("**\(viewModel.sessionNumberTime) min**")
                                Text("de pratique")
                            }
                            .frame(width: 150, height: 60)
                            //                        .background(Color.Palette.sunset)
                            .cornerRadius(24)
                        }
                    }
                    
                }
                
                Spacer()
                
            }
            .font(.body())
            .foregroundColor(.Text.primary())
        }
    }
}

#Preview {
    MeView()
}

final class MeViewModel: ObservableObject {
    private let userRepository = UserRepository()
    
    @Published private(set) var sessionCountsPerDay: [Value] =
    [
        .init(category: "0", value: 0),
        .init(category: "1", value: 0),
        .init(category: "2", value: 1),
        .init(category: "3", value: 0),
        .init(category: "4", value: 1),
        .init(category: "5", value: 0),
        .init(category: "6", value: 1),
     ]
    
    @Published private(set) var sessionsInARow: String = "3"
    @Published private(set) var topSessionsInARow: String = "7"
    @Published private(set) var sessionNumber: String = "14"
    @Published private(set) var sessionNumberTime: String = "14"
    
    init() {
        
    }
    
    
}
