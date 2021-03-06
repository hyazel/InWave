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
    enum Texts {
        static var listTitle: String = "Activités"
    }
    
    // MARK: - States
    @StateObject var viewModel: BreathListViewModel
    @State private var selectedBreath: Breath? = nil
    
    var body: some View {
        ZStack {
            breathList()
                .fullScreenCover(item: $selectedBreath) { breath in
                    BreathPlayerView(viewModel: BreathViewModel(breath: breath))
                }
            
            bottomShadow()
        }
    }
    
    // MARK: - Subviews
    private func breathList() -> some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text(Texts.listTitle)
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .foregroundColor(Color.Text.primary())
                    .font(Font.title2())
                LazyVGrid(
                    columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())],
                    alignment: .center,
                    spacing: 16,
                    pinnedViews: [.sectionHeaders]
                ) {
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
                Color.clear.padding(.bottom, 10)
            }
        }
        .padding(.top, 16)
        .padding([.leading, .trailing], 16)
    }
    
    private func bottomShadow() -> some View {
        VStack {
            Spacer()
            Color.Background.primaryAlpha().frame(maxWidth: .infinity, maxHeight: 36)
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
