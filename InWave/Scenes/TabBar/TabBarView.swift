//
//  TabBarView.swift
//  InWave
//
//  Created by Laurent Droguet on 29/11/2020.
//

import SwiftUI
import Core

struct TabBarView: View {
    // MARK: - States
    @State var isNavigationBarHidden: Bool = true
    @State var selectedTab = "tabbar_home"
    
    // MARK: - Private properties
    private let tabItems = ["tabbar_home", "tabbar_list"]
    
    // MARK: - Init
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // MARK: - View
    var body: some View {
            ZStack {
                Color.Background.primary()
                ZStack {
                    VStack{
                        InWaveTabView(tabItems: tabItems, selectedTab: $selectedTab)
                        TabBar(tabItems: tabItems, selectedTab: $selectedTab)
                    }
                    
                }
                
            }
            .ignoresSafeArea()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


// MARK: - TabBar
struct TabBar: View {
    let tabItems: [String]
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(tabItems, id: \.self) { item in
                Button(action: {
                    withAnimation(.spring()) {
                        selectedTab = item
                    }
                },
                label: {
                    VStack(spacing: 8) {
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color.Palette.blueAccent)
                            .opacity(selectedTab == item ? 1 : 0)
                        
                        Image(item)
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == item ? .white : Color.Palette.c4)
                    }
                })
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical)
        .padding(.bottom,
                 UIApplication.shared.windows.first?.safeAreaInsets.bottom)
    }
}

// MARK: - Custom TabView
struct InWaveTabView: View {
    let tabItems: [String]
    @Binding var selectedTab: String
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: HomeViewModel(dependencies: AppDependencies.container), viewModelTimer: HomeViewModelTimer())
                .tag(tabItems[0])
                .background(Color.Background.primary())
                .navigationTitle("Home")
            
            BreathListView(viewModel: BreathListViewModel())
                .tag(tabItems[1])
        }
    }
}
