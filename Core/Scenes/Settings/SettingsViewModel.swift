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
    var mainAppCoordinator: MainAppCoordinator
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        mainAppCoordinator: MainAppCoordinator
    ) {
        self.mainAppCoordinator = mainAppCoordinator
    }
    
    public func logOut() {
        dependencies
            .userProvider
            .signOut()
            .sink { completion in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                self?.mainAppCoordinator.selectedTab = .login
                print("Logged out")
            }
            .store(in: &cancellables)
    }
}
