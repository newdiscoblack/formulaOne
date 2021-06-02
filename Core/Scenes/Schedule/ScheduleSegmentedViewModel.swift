//
//  ScheduleSegmentedViewModel.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import Combine
import Services
import SwiftUI

class ScheduleSegmentedViewModel: ObservableObject {
    enum State {
        case empty
        case loaded
    }
    
    @Published
    var scheduleState: State = .empty
    
    @Published
    var pastSchedule: [Race]?
    
    @Published
    var upcomingSchedule: [Race]?
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        fetchData()
    }
    
    private func fetchData() {
        fetchCurrentRaceSchedule()
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
                    self?.scheduleState = .empty
                    print(error)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] raceSchedule in
                self?.splitScheduleIntoSegments(
                    raceSchedule.mrData.raceTable.races
                )
                self?.scheduleState = .loaded
            }
            .store(in: &cancellables)
    }
    
    private func splitScheduleIntoSegments(_ schedule: [Race]) {
        let sortedSchedule = schedule
            .map { return ($0, dependencies.dateProvider.dateFrom($0.getFullDate())!) }
            .sorted { $0.1 < $1.1 }
            .map(\.0)
        let currentDate = dependencies.dateProvider.today()
        var upcomingRace: (index: Int, race: Race)?
        
        sortedSchedule.enumerated().forEach { index, race in
            if upcomingRace == nil {
                upcomingRace = (index, race)
            }
            
            guard let upcomingRaceDate = dependencies
                    .dateProvider
                    .dateFrom(race.getFullDate()) else { return }
            
            if currentDate > upcomingRaceDate {
                let nextRaceIndex = sortedSchedule.index(after: index)
                upcomingRace = (nextRaceIndex, sortedSchedule[nextRaceIndex])
                self.pastSchedule = Array(schedule[0...index])
                self.upcomingSchedule = Array(schedule[nextRaceIndex...])
            }
        }
    }
}
