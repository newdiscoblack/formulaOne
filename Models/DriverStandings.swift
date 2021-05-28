//
//  DriverStandings.swift
//  formula-one
//
//  Created by Kacper Jagiello on 17/04/2021.
//

import Foundation

// MARK: - DriverStandings
public struct DriverStandings: Codable {
    let mrData: DriverStandingsMRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - DriverStandingsMRData
struct DriverStandingsMRData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit,
        offset,
        total: String
    let standingsTable: StandingsTable

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
struct StandingsTable: Codable {
    let season: String
    let details: [Standings]

    enum CodingKeys: String, CodingKey {
        case season
        case details = "StandingsLists"
    }
}

// MARK: - Standings
struct Standings: Codable {
    let season,
        round: String
    let drivers: [DriverStanding]

    enum CodingKeys: String, CodingKey {
        case season,
             round
        case drivers = "DriverStandings"
    }
}

// MARK: - DriverStanding
public struct DriverStanding: Codable, Identifiable {
    public let id = UUID()
    let position,
        positionText,
        points,
        wins: String
    let driver: Driver
    let constructors: [Constructor]

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
struct Constructor: Codable, Hashable {
    let constructorID: String
    let url: String
    let name,
        nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url,
             name,
             nationality
    }
}
