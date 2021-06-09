//
//  AppDependencies.swift
//  formula-one
//
//  Created by Kacper Jagiello on 13/04/2021.
//

import Services
import SwiftUI
import Foundation

public struct AppDependencies: AppDependenciesProtocol {
    public var firebaseService: FirebaseServing
    public var firebaseAuthorizer: FirebaseAuthorizing
    public var userProvider: UserProviding
    public var httpService: HttpServing
    public var apiResources: ApiResources
    public var flagProvider: FlagProviding
    public var carProvider: CarProviding
    public var dateProvider: DateProviding
    
    public init() {
        self.firebaseService = FirebaseService()
        self.firebaseAuthorizer = FirebaseAuthorizer()
        self.userProvider = UserProvider()
        self.httpService = HttpService()
        self.apiResources = AppApiResources()
        self.flagProvider = FlagProvider()
        self.carProvider = CarProvider()
        self.dateProvider = DateProvider()
    }
}

public protocol AppDependenciesProtocol:
    HasFirebaseService,
    HasFirebaseAuthorizer,
    HasUserProvider,
    HasHttpService,
    HasApiResources,
    HasFlagProvider,
    HasCarProvider,
    HasDateProvider { }

// MARK: - Environment

struct AppDependenciesKey: EnvironmentKey {
    static var defaultValue: AppDependenciesProtocol = AppDependencies()
}

extension EnvironmentValues {
    var appDependencies: AppDependenciesProtocol {
        get {
            self[AppDependenciesKey.self]
        }
    }
}
