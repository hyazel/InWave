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
                Color.Background.primary().ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        InWaveTabView(tabItems: tabItems, selectedTab: $selectedTab)
                        TabBar(tabItems: tabItems, selectedTab: $selectedTab)
                    }
                }
                .padding(.top, 16)
            }
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
                            .foregroundColor(selectedTab == item ? .white : Color.Palette.lake)
                    }
                })
                Spacer()
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom,
                 UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 32 : 32)
    }
}

// MARK: - Custom TabView
struct InWaveTabView: View {
    let tabItems: [String]
    @Binding var selectedTab: String
    
    var body: some View {
        TabView(selection: $selectedTab) {
                HomeView(viewModel: HomeViewModel(dependencies: AppDependencies.container), viewModelTimer: HomeViewModelTimer())
                    .background(BackgroundHelper())
                    .tag(tabItems[0])

                BreathListView(viewModel: BreathListViewModel())
                    .background(BackgroundHelper())
                    .tag(tabItems[1])
        }
    }
}

struct BackgroundHelper: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // find first superview with color and make it transparent
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor.clear
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
