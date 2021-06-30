//
//  MainTabViewModel.swift
//  Core
//
//  Created by Kacper Jagiello on 08/06/2021.
//

import SwiftUI

public class MainTabViewModel: ObservableObject {
    @ObservedObject
    var rootViewCoordinator: RootViewCoordinator
    
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    public init(
        rootViewCoordinator: RootViewCoordinator,
        mainTabViewCoordinator: MainTabViewCoordinator
    ) {
        self.rootViewCoordinator = rootViewCoordinator
        self.mainTabViewCoordinator = mainTabViewCoordinator
    }
}
