//
//  RaceScheduleInformation.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 10/05/2021.
//

import Foundation

// MARK: - RaceScheduleInformation
public struct RaceScheduleInformation: Codable {
    let mrData: RaceScheduleInformationMRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - RaceScheduleInformationMRData
struct RaceScheduleInformationMRData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit,
        offset,
        total: String
    let raceTable: RaceTable

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
struct RaceTable: Codable {
    let season: String
    let races: [Race]
    
    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

// MARK: - Race
struct Race: Codable {
    let season: String
    let round: String
    let url: String
    let name: String
    let circuit: Circuit
    let date: String
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case season,
             round,
             url,
             date,
             time
        case name = "raceName"
        case circuit = "Circuit"
    }
    
    func getFullDate() -> String {
        return "\(date) \(time)"
    }
}

// MARK: - Circuit
struct Circuit: Codable {
    let id: String
    let url: String
    let name: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "circuitId"
        case url
        case name = "circuitName"
        case location = "Location"
    }
}

// MARK: - Location
public struct Location: Codable {
    let latitude: String
    let longitude: String
    let locality: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
        case locality,
             country
    }
}
