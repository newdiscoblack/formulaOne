//
//  FormulaOneApp.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import Core
import SwiftUI

@main
struct FormulaOneApp: App {
    @StateObject
    var mainTabViewCoordinator: MainTabViewCoordinator = MainTabViewCoordinator()
    
    @StateObject
    var mainAppCoordinator: MainAppCoordinator = MainAppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                OnboardingView(
                    mainAppCoordinator: mainAppCoordinator,
                    mainTabViewCoordinator: mainTabViewCoordinator
                )
//                MainTabView(
//                    coordinator: mainTabViewCoordinator
//                )
//                LaunchScreen()
            } 
        }
    }
}
