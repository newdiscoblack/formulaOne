//
//  HomeViewModel.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import Combine
import Services
import SwiftUI

class HomeViewModel: ObservableObject {
    enum State {
        case empty
        case loaded
    }
    
    @Published
    var nextRaceState: State = .empty
    
    @Published
    var standingsState: State = .empty
    
    @Published
    var raceSchedule: RaceTable?
    
    @Published
    var nextRoundIndex: Int?
    
    @Published
    var upcomingRace: Race?

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
        fetchCurrentRaceSchedule()
        fetchCurrentDriverStandings()
    }
    
    private func fetchCurrentRaceSchedule() {
        dependencies
            .apiResources
            .getCurrentSeasonRaceSchedule(
                dependencies.httpService
            )
            .receive(on: RunLoop.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.nextRaceState = .empty
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] raceSchedule in
                self?.raceSchedule = raceSchedule.mrData.raceTable
                self?.upcomingRace = self?.getUpcomingRace(from: raceSchedule.mrData.raceTable.races)
                self?.nextRaceState = .loaded
            }
            .store(in: &cancellables)
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
    
    public func getUpcomingRace(from schedule: [Race]) -> Race? {
        let sortedSchedule = schedule
            .map { return ($0, dependencies.dateProvider.dateFrom($0.getFullDate())!) }
            .sorted { $0.1 < $1.1 }
            .map(\.0)
        let currentDate = dependencies.dateProvider.today()
        var upcomingRace: Race?
        
        // MARK: - TODO - Tests
        
        sortedSchedule.enumerated().forEach { index, race in
            if upcomingRace == nil {
                upcomingRace = race
            }
            
            guard let raceDate = dependencies
                    .dateProvider
                    .dateFrom(race.getFullDate()) else { return }
            
            if currentDate > raceDate {
                let nextRaceIndex = sortedSchedule.index(after: index)
                upcomingRace = sortedSchedule[nextRaceIndex]
            }
        }
        return upcomingRace
    }
}
