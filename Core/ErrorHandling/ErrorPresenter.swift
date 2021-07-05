//
//  ErrorPresenter.swift
//  Core
//
//  Created by Kacper Jagiełło on 02/07/2021.
//

import SwiftUI

public protocol HasErrorPresenter {
    var errorPresenter: ErrorPresenter { get }
}

struct DisplayableError: Error {
    let shouldBeDisplayed: Bool
    let localizedDescription: String
    let underlyingError: Error?
}

public class ErrorPresenter: ObservableObject {
    @Published
    var displayableError: DisplayableError?
    
    public static let shared = ErrorPresenter()
    
    private init() { }
    
    public func present(_ error: Error) {
        displayableError = DisplayableError(
            shouldBeDisplayed: true,
            localizedDescription: error.localizedDescription,
            underlyingError: error
        )
    }
}
