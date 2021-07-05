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
    public var viewFactory: ViewFactory
    public var errorPresenter: ErrorPresenter
    public var flagProvider: FlagProviding
    public var carProvider: CarProviding
    public var dateProvider: DateProviding
    
    public init() {
        self.firebaseService = FirebaseService()
        self.firebaseAuthorizer = FirebaseAuthorizer()
        self.userProvider = UserProvider()
        self.httpService = HttpService()
        self.apiResources = AppApiResources()
        self.viewFactory = ViewFactory()
        self.errorPresenter = ErrorPresenter.shared
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
    HasViewFactory,
    HasErrorPresenter,
    HasFlagProvider,
    HasCarProvider,
    HasDateProvider { }

// MARK: - Environment

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue: AppDependenciesProtocol = AppDependencies()
}

private struct ErrorPresenterKey: EnvironmentKey {
    static var defaultValue: ErrorPresenter = ErrorPresenter.shared
}

extension EnvironmentValues {
    public var appDependencies: AppDependenciesProtocol {
        get { self[AppDependenciesKey.self] }
    }
    
    public var errorPresenter: ErrorPresenter {
        get { self[ErrorPresenterKey.self] }
        set { self[ErrorPresenterKey.self] = newValue }
    }
}
