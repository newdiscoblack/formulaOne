//
//  Navigation.swift
//  Core
//
//  Created by Kacper Jagiełło on 30/06/2021.
//

import Combine

public protocol Navigating {
    var navigationPublisher: AnyPublisher<NavigationDirection, Never> { get }
}

public enum NavigationDirection {
    case dismiss
    case navigate(to: NavigationDestination, style: NavigationStyle)
}

public enum NavigationStyle {
    case push
    case present
}

public protocol NavigationDestination {
/*
     Confirm to this protocol while creating separate enums for possible
     destinations. This way, every possible app destination is
     NavigationDestination, but they can be separated into different types.
 */
}

enum TestDestination: NavigationDestination {
    case firstView
    case secondView
}
