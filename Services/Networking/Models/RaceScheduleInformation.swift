//
//  RaceScheduleInformation.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 10/05/2021.
//

import Foundation

// MARK: - RaceScheduleInformation
public struct RaceScheduleInformation: Codable {
    public let mrData: RaceScheduleInformationMRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - RaceScheduleInformationMRData
public struct RaceScheduleInformationMRData: Codable {
    public let xmlns: String
    public let series: String
    public let url: String
    public let limit,
        offset,
        total: String
    public let raceTable: RaceTable

    enum CodingKeys: String, CodingKey {
        case xmlns,
             series,
             url,
             limit,
             offset,
             total
        case raceTable = "RaceTable"
    }
}

// MARK: - RaceTable
public struct RaceTable: Codable {
    public let season: String
    public let races: [Race]
    
    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
public struct Race: Codable {
    public let season: String
    public let round: String
    public let url: String
    public let name: String
    public let circuit: Circuit
    public let date: String
    public let time: String
    
    enum CodingKeys: String, CodingKey {
        case season,
             round,
             url,
             date,
             time
        case name = "raceName"
        case circuit = "Circuit"
    }
    
    public func getFullDate() -> String {
        return "\(date) \(time)"
    }
}

// MARK: - Circuit
public struct Circuit: Codable {
    public let id: String
    public let url: String
    public let name: String
    public let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "circuitId"
        case url
        case name = "circuitName"
        case location = "Location"
    }
}

// MARK: - Location
public struct Location: Codable {
    public let latitude: String
    public let longitude: String
    public let locality: String
    public let country: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
        case locality,
             country
    }
}
