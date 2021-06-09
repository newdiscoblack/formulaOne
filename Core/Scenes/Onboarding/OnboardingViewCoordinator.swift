//
//  OnboardingViewCoordinator.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import Foundation
import SwiftUI

public enum OnboardingScreen {
    case login
    case mainTabView
}

public class MainAppCoordinator: ObservableObject {
    @Published
    var selectedTab: OnboardingScreen = .login
    
    public init() { }
}

