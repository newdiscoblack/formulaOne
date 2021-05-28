//
//  ApiError.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import Foundation

public enum ApiError: Error {
    case invalidServerResponse(URLResponse)
    case responseError(Int)
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse(let urlResponse):
            return "Invalid server response: \(urlResponse.debugDescription)."
        case .responseError(let statusCode):
            switch statusCode {
            case 404:
                return "Error \(statusCode): The requested resource could not be found."
            case 500:
                return "Error \(statusCode): Internal server error."
            default:
                return "Unknown error: \(statusCode)."
            }
        }
    }
}
