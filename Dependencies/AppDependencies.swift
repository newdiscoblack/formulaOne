//
//  AppDependencies.swift
//  formula-one
//
//  Created by Kacper Jagiello on 13/04/2021.
//

import SwiftUI
import Foundation

public struct AppDependencies: AppDependenciesProtocol {
    public var httpService: HttpServing
    public var apiResources: ApiResources
    public var flagProvider: FlagProviding
    public var carProvider: CarProviding
    public var dateProvider: DateProviding
    
    public init() {
        self.httpService = HttpService()
        self.apiResources = AppApiResources()
        self.flagProvider = FlagProvider()
        self.carProvider = CarProvider()
        self.dateProvider = DateProvider()
    }
}

public protocol AppDependenciesProtocol:
    HasHttpService,
    HasApiResources,
    HasFlagProvider,
    HasCarProvider,
    HasDateProvider { }
