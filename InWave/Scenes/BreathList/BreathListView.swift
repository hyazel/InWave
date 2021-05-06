//
//  BreathListView.swift
//  InWave
//
//  Created by Laurent Droguet on 10/02/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Core
import DesignSystem

struct BreathListView: View {
    @StateObject var viewModel: BreathListViewModel
    @State private var selectedBreath: Breath? = nil
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(
                        columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())],
                        alignment: .center,
                        spacing: 16,
                        pinnedViews: [.sectionHeaders]
                    ) {
                        Section(header: Text("Activités")
                                    .frame(maxWidth: .infinity,
                                           alignment: .leading)
                                    .foregroundColor(.white)
                                    .padding(.leading, 0)) {
                            ForEach(Array(viewModel.breathCellViewModels.enumerated()), id: \.element.id) { (index, breath) in
                                Button(action: {
                                    selectedBreath = viewModel.selectedBreath(index: index)
                                }, label: {
                                    BreathCard(imageName: breath.iconName,
                                               title: breath.title,
                                               subtitle: breath.subtitle,
                                               duration: breath.duration,
                                               imageSize: CGSize(width: 72, height: 72))
                                })
                                .buttonStyle(PressableButtonStyle())
                            }
                        }
                    }
                    Color.clear.padding(.bottom, 10)
                }
                
            }
            .padding(.top, 16)
            .padding([.leading, .trailing], 16)
            .fullScreenCover(item: $selectedBreath) { breath in
                BreathPlayerView(viewModel: BreathViewModel(breath: breath))
            }
            
            VStack {
                Spacer()
                Color.Background.primaryAlpha().frame(maxWidth: .infinity, maxHeight: 36)
            }
        }
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Background.primary().ignoresSafeArea()
            BreathListView(viewModel: BreathListViewModel())
        }
    }
}
