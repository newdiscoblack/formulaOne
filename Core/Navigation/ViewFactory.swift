//
//  ViewFactory.swift
//  Core
//
//  Created by Kacper Jagiełło on 30/06/2021.
//

import SwiftUI

public protocol HasViewFactory {
    var viewFactory: ViewFactory { get }
}

public struct ViewFactory {
    @ViewBuilder
    public func buildRootView(
        rootCoordinator: RootViewCoordinator,
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        RootView(
            rootViewCoordinator: rootCoordinator,
            mainTabViewCoordinator: tabCoordinator
        )
    }
    
    @ViewBuilder
    public func buildTabBar(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        TabBar(coordinator: tabCoordinator)
            .alignmentGuide(.bottom) { dimension in
                dimension[.bottom]
            }
            .isHidden(
                !tabCoordinator
                    .shouldDisplayTabBar
            )
    }
    
    @ViewBuilder
    public func buildHomeView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        HomeView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: HomeViewModel()
        )
    }
    
    @ViewBuilder
    public func buildRaceScheduleView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        ScheduleSegmentedView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: ScheduleSegmentedViewModel()
        )
    }
    
    @ViewBuilder
    public func buildStandingsView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        StandingsView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: StandingsViewModel()
        )
    }
    
    @ViewBuilder
    public func buildSettingsView(
        rootCoordinator: RootViewCoordinator
    ) -> some View {
        SettingsView(
            viewModel: SettingsViewModel(
                rootViewCoordinator: rootCoordinator
            )
        )
    }
    
    @ViewBuilder
    public func buildDestination(
        _ destination: NavigationDestination
    ) -> some View {
        switch destination {
        case LoginDestination.signIn:
            Text("Sign in view.")
        default:
            Text("View is yet to be created.")
        }
    }
}
