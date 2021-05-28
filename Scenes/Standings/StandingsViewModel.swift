//
//  StandingsViewModel.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import Combine
import SwiftUI

class StandingsViewModel: ObservableObject {
    enum State {
        case empty
        case loaded
    }
    
    @Published
    var standingsState: State = .empty
    
    @Published
    var standings: StandingsTable?
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        setup()
    }

    private func setup() {
        fetchData()
    }
    
    private func fetchData() {
        fetchCurrentDriverStandings()
    }
    
    private func fetchCurrentDriverStandings() {
        dependencies
            .apiResources
            .getCurrentDriverStandings(
                dependencies.httpService
            )
            .receive(on: RunLoop.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.standingsState = .empty
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] standings in
                self?.standings = standings.mrData.standingsTable
                self?.standingsState = .loaded
            }
            .store(in: &cancellables)
    }
}
