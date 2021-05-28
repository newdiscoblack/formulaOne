//
//  DriverCellViewModel.swift
//  formula-one
//
//  Created by Kacper Jagiello on 18/04/2021.
//

import Foundation
import Services

public struct DriverCellViewModel {
    public let position: String
    public let points: String
    public let wins: String
    public let name: String
    public let surname: String
    public let number: String
    public let nationality: String
    public let constructor: String
    
    public static func populateWith(
        _ standing: DriverStanding
    ) -> DriverCellViewModel {
        return DriverCellViewModel(
            position: standing.position,
            points: standing.points,
            wins: standing.wins,
            name: standing.driver.givenName,
            surname: standing.driver.familyName,
            number: standing.driver.permanentNumber,
            nationality: standing.driver.nationality,
            constructor: standing.constructors.first?.name ?? "NaN"
        )
    }
}
