//
//  FormulaOneApp.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import SwiftUI

@main
struct FormulaOneApp: App {
    @StateObject
    var mainTabViewCoordinator: MainTabViewCoordinator = MainTabViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                coordinator: mainTabViewCoordinator
            )
        }
    }
}