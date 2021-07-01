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
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    @StateObject
    var mainTabViewCoordinator: MainTabViewCoordinator = MainTabViewCoordinator()
    
    @StateObject
    var rootViewCoordinator: RootViewCoordinator = RootViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                dependencies
                    .viewFactory
                    .buildRootView(
                        rootCoordinator: rootViewCoordinator,
                        tabCoordinator: mainTabViewCoordinator
                    )
                VStack {
                    Text("Error: Something went wrong :(")
                        .frame(maxWidth: .infinity, maxHeight: 80)
                        .foregroundColor(.white)
                        .background(
                            Color.red
                        )
                    Spacer()
                }
                .isHidden(!rootViewCoordinator.isPresentingError)
            } 
        }
    }
}
