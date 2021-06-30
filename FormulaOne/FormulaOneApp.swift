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
    var rootViewCoordinator: RootViewCoordinator = RootViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RootView(
                    rootViewCoordinator: rootViewCoordinator,
                    mainTabViewCoordinator: mainTabViewCoordinator
                )
            } 
        }
    }
}
