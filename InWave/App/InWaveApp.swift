//
//  InWaveApp.swift
//  InWave
//
//  Created by Laurent Droguet on 13/11/2020.
//

import SwiftUI
import Core
import DesignSystem

@main
struct InWaveApp: App {
    
    // MARK: - AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - State
    @State var startRootView = false
    @State var hideSplashScreen = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if !hideSplashScreen {
                    SplashScreen()
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.startRootView = true
                            }
                        }
                }
                
                if startRootView {
                    RootViewCoordinator(viewModel: RootViewModel(dependencies: AppDependencies.container))
                        .background(BackgroundView(color: Color.clear))
                        .transition(AnyTransition.opacity.animation(.easeIn(duration: 1)))
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                hideSplashScreen = true
                            }
                        }
                }
            }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        AppDependencies.make()
        
        return true
    }
}
