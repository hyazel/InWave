//
//  RootViewCoordinator.swift
//  InWave
//
//  Created by Laurent Droguet on 06/03/2021.
//  Copyright © 2021 InWave . All rights reserved.
//

import SwiftUI
import Core

struct RootViewCoordinator: View {
    // MARK: - States
    @ObservedObject var viewModel: RootViewModel
    @State var onBoadingHasFinished = false
    
    // MARK: - View
    var body: some View {
        Group {
            if viewModel.onBoardingDone || onBoadingHasFinished {
                TabBarView()
            } else {
                OnBoarding() {
                    onBoadingHasFinished = true
                    viewModel.setOnBoardingToDone()
                }
            }
        }
    }
}

// MARK: - Preview
struct RootViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        RootViewCoordinator(viewModel: RootViewModel(dependencies: AppDependencies.container))
    }
}
