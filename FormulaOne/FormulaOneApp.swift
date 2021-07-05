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
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                dependencies
                    .viewFactory
                    .buildRootView()
            }
        }
    }
}
