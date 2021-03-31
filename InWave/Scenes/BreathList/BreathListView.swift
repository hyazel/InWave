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
            Color.Background.primary().ignoresSafeArea()
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())],
                    alignment: .center,
                    spacing: 16,
                    pinnedViews: [.sectionHeaders, .sectionFooters]
                ) {
                    Section(header: Text("Activités").frame(maxWidth: .infinity, alignment: .leading).foregroundColor(.white).padding(.leading, 0)) {
                        ForEach(Array(viewModel.breathCellViewModels.enumerated()), id: \.element.id) { (index, breath) in
                            BreathCard(imageName: breath.iconName,
                                       title: breath.title,
                                       subtitle: breath.subtitle,
                                       duration: breath.duration)
                                .onTapGesture {
                                    selectedBreath = viewModel.selectedBreath(index: index)
                                       }
                        }
                    }
                }
            }
            .padding(.top, 16)
            .padding([.leading, .trailing], 16)
            .sheet(item: $selectedBreath) { breath in
                BreathPlayerView(viewModel: BreathViewModel(breath: breath))
            }
        }
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BreathListView(viewModel: BreathListViewModel())
        }
    }
}
