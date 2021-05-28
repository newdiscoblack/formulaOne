//
//  MainTabViewCoordinator.swift
//  formula-one
//
//  Created by Kacper Jagiello on 11/04/2021.
//

import Foundation

enum MainTab {
    case home
    case schedule
    case standings
}

public class MainTabViewCoordinator: ObservableObject {
    @Published
    var selectedTab: MainTab = .home
    
    @Published
    var shouldDisplayTabBar: Bool = true
}
