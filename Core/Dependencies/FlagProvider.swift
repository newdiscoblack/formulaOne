//
//  NationalityService.swift
//  formula-one
//
//  Created by Kacper Jagiello on 19/04/2021.
//

import Foundation

public protocol FlagProviding {
    func nationality(
        _ nationality: String
    ) -> String
    
    func country(
        _ country: String
    ) -> String
}

public protocol HasFlagProvider {
    var flagProvider: FlagProviding { get }
}

public struct FlagProvider: FlagProviding {
    public init() { }
    public func nationality(_ nationality: String) -> String {
        switch nationality.lowercased() {
        case "british":
            return "🇬🇧"
        case "dutch":
            return "🇳🇱"
        case "austrian":
            return "🇦🇹"
        default:
            return "🏁"
        }
    }
    
    public func country(_ country: String) -> String {
        switch country.lowercased() {
        case "monaco":
            return "🇲🇨"
        default:
            return "🏁"
        }
    }
}
