//
//  EnvironmentValues.swift
//  formula-one
//
//  Created by Kacper Jagiello on 17/04/2021.
//

import SwiftUI

struct AppDependenciesKey: EnvironmentKey {
    static var defaultValue: AppDependenciesProtocol = AppDependencies()
}

extension EnvironmentValues {
    var appDependencies: AppDependenciesProtocol {
        get {
            self[AppDependenciesKey.self]
        }
        set {
            self[AppDependenciesKey.self] = newValue
        }
    }
}

extension View {
    func inject(
        _ appDependencies: AppDependenciesProtocol
    ) -> some View {
        environment(\.appDependencies, appDependencies)
    }
}
