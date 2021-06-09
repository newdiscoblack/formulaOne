//
//  MainTabViewModel.swift
//  Core
//
//  Created by Kacper Jagiello on 08/06/2021.
//

import SwiftUI

public class MainTabViewModel: ObservableObject {
    @ObservedObject
    var mainAppCoordinator: MainAppCoordinator
    
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    public init(
        mainAppCoordinator: MainAppCoordinator,
        mainTabViewCoordinator: MainTabViewCoordinator
    ) {
        self.mainAppCoordinator = mainAppCoordinator
        self.mainTabViewCoordinator = mainTabViewCoordinator
    }
}
