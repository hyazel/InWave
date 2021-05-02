//
//  InWaveApp.swift
//  InWave
//
//  Created by Laurent Droguet on 13/11/2020.
//

import SwiftUI
import Core

@main
struct InWaveApp: App {
    // MARK: - Delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - State
    @State var startRootView = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if startRootView {
                    RootViewCoordinator(viewModel: RootViewModel(dependencies: AppDependencies.container)).transition(.identity)
                } else {
                    SplashScreen().onAppear() {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            startRootView = true
                        }
                    }
                }
            }
            .transition(.opacity)
            .animation(.easeInOut)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        AppDependencies.make()
        
        return true
    }
}
