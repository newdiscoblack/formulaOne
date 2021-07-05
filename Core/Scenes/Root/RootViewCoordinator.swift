//
//  RootViewCoordinator.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import Combine
import SwiftUI

public enum RootScreen {
    case login
    case mainTabView
}

public class RootViewCoordinator: ObservableObject {
    @Published
    public var selectedScreen: RootScreen = .login

    public static let shared: RootViewCoordinator = RootViewCoordinator()
    
    private init() { }
}
