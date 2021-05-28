//
//  RacingResources.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 10/05/2021.
//

import Combine
import Foundation

public protocol RacingResources {
    typealias GetCurrentSeasonRaceSchedule = (
        HttpServing
    ) -> AnyPublisher<RaceScheduleInformation, Error>
    var getCurrentSeasonRaceSchedule: GetCurrentSeasonRaceSchedule { get }
    
    typealias GetRaceSchedule = (
        Int,
        Int?,
        HttpServing
    ) -> AnyPublisher<RaceScheduleInformation, Error>
    var getRaceSchedule: GetRaceSchedule { get }
}

extension AppApiResources {
    public var getCurrentSeasonRaceSchedule: (
        HttpServing
    ) -> AnyPublisher<RaceScheduleInformation, Error> {
        return { httpService in
            let endpoint = Ergast.makeRequest(
                for: .getCurrentSeasonRaceSchedule
            )
            return httpService
                .fetchDataFrom(endpoint)
        }
    }
    
    public var getRaceSchedule: (
        Int,
        Int?,
        HttpServing
    ) -> AnyPublisher<RaceScheduleInformation, Error> {
        return { season, round, httpService in
            let endpoint = Ergast.makeRequest(
                for: .getRaceSchedule(
                    season: season,
                    round: round
                )
            )
            return httpService
                .fetchDataFrom(endpoint)
        }
    }
}
