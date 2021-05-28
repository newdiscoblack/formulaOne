//
//  Ergast.swift
//  formula-one
//
//  Created by Kacper Jagiello on 09/04/2021.
//

import Foundation
import Combine

public protocol EndpointProviding {
    associatedtype Endpoint
    static var baseUrl: String { get set }
    static func makeRequest(
        for endpoint: Endpoint
    ) -> URL
}

struct Ergast: EndpointProviding {
    internal static var baseUrl: String = "https://ergast.com/api"
    
    static func makeRequest(
        for endpoint: Endpoint
    ) -> URL {
        return URL(string: baseUrl + endpoint.path + ".json")!
    }
    
    enum Endpoint {
        case getInformationAboutSingleDriver(
                _ driver: String
             )
        case getCurrentSeasonRaceSchedule
        case getRaceSchedule(
                season: Int,
                round: Int? = nil
             )
        case getCurrentDriverStandings
        
        var path: String {
            switch self {
            case .getInformationAboutSingleDriver(let driver):
                return "/f1/drivers/\(driver)"
            case .getCurrentSeasonRaceSchedule:
                return "/f1/current"
            case .getRaceSchedule(let season, let round):
                return round != nil ?
                    "/f1/\(season)/\(String(describing: round))"
                    : "/f1/\(season)"
            case .getCurrentDriverStandings:
                return "/f1/current/driverStandings"
            }
        }
    }
}

