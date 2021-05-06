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
                        .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.5)))
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

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        AppDependencies.make()
        
        return true
    }
}

struct BackgroundView: UIViewRepresentable {
    let color: Color
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            // find first superview with color and make it transparent
            var parent = view.superview
            repeat {
                if parent?.backgroundColor != nil {
                    parent?.backgroundColor = UIColor(color)
                    break
                }
                parent = parent?.superview
            } while (parent != nil)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
