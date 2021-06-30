//
//  View+handleNavigation.swift
//  Core
//
//  Created by Kacper Jagiełło on 30/06/2021.
//

import Combine
import SwiftUI

extension View {
    func handleNavigation(
        _ navigationPublisher: AnyPublisher<NavigationDirection, Never>
    ) -> some View {
        self.modifier(
            NavigationHandler(
                navigationPublisher: navigationPublisher
            )
        )
    }
}
