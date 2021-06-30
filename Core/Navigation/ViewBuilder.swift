//
//  ViewBuilder.swift
//  Core
//
//  Created by Kacper Jagiełło on 30/06/2021.
//

import SwiftUI

struct ViewFactory {
    @ViewBuilder
    func destination(_ destination: NavigationDestination) -> some View {
        switch destination {
        case LoginDestination.signIn:
            Text("Sign in view.")
        default:
            Text("View is yet to be created.")
        }
    }
}
