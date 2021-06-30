//
//  SettingsViewModel.swift
//  Core
//
//  Created by Kacper Jagiełło on 09/06/2021.
//

import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    @ObservedObject
    var rootViewCoordinator: RootViewCoordinator
    
    @Published
    var availableSettings: [SettingsOption] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        rootViewCoordinator: RootViewCoordinator
    ) {
        _rootViewCoordinator = ObservedObject(wrappedValue: rootViewCoordinator)
        self.availableSettings = [
            .profile,
            .logout(logout)
        ]
    }
    
    private func logout() {
        dependencies
            .userProvider
            .signOut()
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Logged out succesfully.")
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.rootViewCoordinator.selectedScreen = .login
            }
            .store(in: &cancellables)
    }
}

enum SettingsOption {
    typealias Action = () -> Void
    
    case profile
    case logout(Action)
    
    var icon: Image {
        switch self {
        case .profile:
            return Image(systemName: "person")
        case .logout:
            return Image(systemName: "power")
        }
    }
    
    var title: Text {
        switch self {
        case .profile:
            return Text("Profile")
        case .logout:
            return Text("Logout")
        }
    }
    
    var action: () -> Void {
        switch self {
        case .logout(let action):
            return action
        default:
            return {}
        }
    }
}
