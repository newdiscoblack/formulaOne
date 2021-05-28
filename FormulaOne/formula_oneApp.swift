//
//  formula_oneApp.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import SwiftUI

@main
struct formula_oneApp: App {
    @StateObject
    var mainCoordinator: MainTabViewCoordinator = MainTabViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            MainTabView(
                coordinator: mainCoordinator
            )
        }
    }
}
