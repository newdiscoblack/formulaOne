//
//  MainTabViewCoordinator.swift
//  formula-one
//
//  Created by Kacper Jagiello on 11/04/2021.
//

import Foundation

public enum MainTab {
    case home
    case schedule
    case standings
    case settings
}

public class MainTabViewCoordinator: ObservableObject {
    @Published
    var selectedTab: MainTab = .home
    
    @Published
    var shouldDisplayTabBar: Bool = true
    
    public init() { }
}
