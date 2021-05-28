//
//  CarProvider.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 27/05/2021.
//

import SwiftUI

public protocol CarProviding {
    func team(
        _ team: String
    ) -> Image
}

public protocol HasCarProvider {
    var carProvider: CarProviding { get }
}

public struct CarProvider: CarProviding {
    public func team(_ team: String) -> Image {
        return Image(
            "\(team.lowercased().filter { !" \n\t\r".contains($0) })_car"
        )
        .resizable()
    }
}
