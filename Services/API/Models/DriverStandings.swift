//
//  DriverStandings.swift
//  formula-one
//
//  Created by Kacper Jagiello on 17/04/2021.
//

import Foundation

// MARK: - DriverStandings
public struct DriverStandings: Codable {
    public let mrData: DriverStandingsMRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - DriverStandingsMRData
public struct DriverStandingsMRData: Codable {
    public let xmlns: String
    public let series: String
    public let url: String
    public let limit,
        offset,
        total: String
    public let standingsTable: StandingsTable

    enum CodingKeys: String, CodingKey {
        case xmlns,
             series,
             url,
             limit,
             offset,
             total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - StandingsTable
public struct StandingsTable: Codable {
    public let season: String
    public let details: [Standings]

    enum CodingKeys: String, CodingKey {
        case season
        case details = "StandingsLists"
    }
}

// MARK: - Standings
public struct Standings: Codable {
    public let season,
        round: String
    public let drivers: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case season,
             round
        case drivers = "DriverStandings"
    }
}

// MARK: - DriverStanding
public struct DriverStanding: Codable, Identifiable {
    public let id = UUID()
    public let position,
        positionText,
        points,
        wins: String
    public let driver: Driver
    public let constructors: [Constructor]

    enum CodingKeys: String, CodingKey {
        case position,
             positionText,
             points,
             wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

// MARK: - Constructor
public struct Constructor: Codable, Hashable {
    public let constructorID: String
    public let url: String
    public let name,
        nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url,
             name,
             nationality
    }
}
