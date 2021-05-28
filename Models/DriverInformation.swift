//
//  DriverInformation.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import Foundation

// MARK: - DriverInformation
public struct DriverInformation: Codable {
    let mrData: DriverInformationMRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - DriverInformationMRData
struct DriverInformationMRData: Codable {
    let xmlns: String
    let series: String
    let url: String
    let limit,
        offset,
        total: String
    let driverTable: DriverTable

    enum CodingKeys: String, CodingKey {
        case xmlns,
             series,
             url,
             limit,
             offset,
             total
        case driverTable = "DriverTable"
    }
}

// MARK: - DriverTable
struct DriverTable: Codable {
    let driverID: String
    let drivers: [Driver]

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case drivers = "Drivers"
    }
}

// MARK: - Driver
struct Driver: Codable, Hashable {
    let driverID,
        permanentNumber,
        code: String
    let url: String
    let givenName,
        familyName,
        dateOfBirth,
        nationality: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case permanentNumber,
             code,
             url,
             givenName,
             familyName,
             dateOfBirth,
             nationality
    }
}
