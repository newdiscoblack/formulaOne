//
//  DriverResources.swift
//  formula-one
//
//  Created by Kacper Jagiello on 13/04/2021.
//

import Combine
import Foundation

public protocol DriverResources {
    typealias GetSingleDriver = (
        String,
        HttpServing
    ) -> AnyPublisher<DriverInformation, Error>
    var getInformationAboutSingleDriver: GetSingleDriver { get }
    
    typealias GetCurrentDriverStandings = (
        HttpServing
    ) -> AnyPublisher<DriverStandings, Error>
    var getCurrentDriverStandings: GetCurrentDriverStandings { get }
}

extension AppApiResources {
    public var getInformationAboutSingleDriver: (
        String,
        HttpServing
    ) -> AnyPublisher<DriverInformation, Error> {
        return { driversName, httpService in
            let endpoint = Ergast.makeRequest(
                for: .getInformationAboutSingleDriver(driversName)
            )
            return httpService
                .fetchDataFrom(endpoint)
        }
    }
    
    public var getCurrentDriverStandings: (
        HttpServing
    ) -> AnyPublisher<DriverStandings, Error> {
        return { httpService in
            let endpoint = Ergast.makeRequest(
                for: .getCurrentDriverStandings
            )
            return httpService
                .fetchDataFrom(endpoint)
        }
    }
}
