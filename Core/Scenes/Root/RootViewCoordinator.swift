//
//  RootViewCoordinator.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import Foundation
import SwiftUI

public enum RootScreen {
    case login
    case mainTabView
}

public class RootViewCoordinator: ObservableObject {
    @Published
    var selectedScreen: RootScreen = .login
    
    public init() { }
}

