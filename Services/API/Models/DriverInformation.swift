//
//  DriverInformation.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import Foundation

// MARK: - DriverInformation
public struct DriverInformation: Codable {
    public let mrData: DriverInformationMRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - DriverInformationMRData
public struct DriverInformationMRData: Codable {
    public let xmlns: String
    public let series: String
    public let url: String
    public let limit,
        offset,
        total: String
    public let driverTable: DriverTable

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
public struct DriverTable: Codable {
    public let driverID: String
    public let drivers: [Driver]

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case drivers = "Drivers"
    }
}

// MARK: - Driver
public struct Driver: Codable, Hashable {
    public let driverID,
        permanentNumber,
        code: String
    public let url: String
    public let givenName,
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
