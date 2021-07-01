//
//  LoginViewModel.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import Combine
import Services
import SwiftUI

public enum LoginDestination: NavigationDestination {
    case signIn
}

class LoginViewModel: ObservableObject, Navigating {
    enum State {
        case idle
        case login
        case loggedIn
    }

    @ObservedObject
    var coordinator: RootViewCoordinator
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    private let navigationSubject = PassthroughSubject<NavigationDirection, Never>()
    
    var navigationPublisher: AnyPublisher<NavigationDirection, Never> {
        navigationSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published
    var state: State = .idle
    
    @Published
    var username: String = ""
    
    @Published
    var password: String = ""
    
    public init(
        coordinator: RootViewCoordinator
    ) {
        self.coordinator = coordinator
        
        #if DEBUG
        username = "test@test.com"
        password = "test123"
        #endif
    }
    
    public func logIn() {
        dependencies
            .userProvider
            .signIn(
                withEmail: username,
                password: password
            )
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.state = .loggedIn
                self?.coordinator.selectedScreen = .mainTabView
            }
            .store(in: &cancellables)
    }
    
    public func signIn() {
        navigationSubject.send(
            .navigate(
                to: LoginDestination.signIn,
                style: .push
            )
        )
    }
}
