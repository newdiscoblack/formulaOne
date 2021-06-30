//
//  LoginViewModel.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import Combine
import Services
import SwiftUI

class LoginViewModel: ObservableObject {
    enum State {
        case idle
        case login
        case loggedIn
    }
    
    @ObservedObject
    var coordinator: RootViewCoordinator
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
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
}
