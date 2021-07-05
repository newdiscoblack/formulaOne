//
//  SettingsViewModel.swift
//  Core
//
//  Created by Kacper Jagiełło on 09/06/2021.
//

import Combine
import SwiftUI

class SettingsViewModel: ObservableObject, Navigating {
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol

    @ObservedObject
    var rootViewCoordinator: RootViewCoordinator
    
    @Published
    var availableSettings: [SettingsOption] = []
    
    private let navigationSubject = PassthroughSubject<NavigationDirection, Never>()
    
    var navigationPublisher: AnyPublisher<NavigationDirection, Never> {
        navigationSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
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
    
    public func navigate(to destination: NavigationDestination) {
        navigationSubject.send(
            .navigate(
                to: destination,
                style: .push
            )
        )
    }
    
    private func logout() {
        dependencies
            .userProvider
            .signOut()
            .sink { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.dependencies.errorPresenter.present(error)
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

public enum SettingsOption: NavigationDestination {
    public typealias Action = () -> Void
    
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
