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

public class ViewFactory {
    public func buildRootView() -> some View {
        RootView(
            rootViewCoordinator: RootViewCoordinator.shared,
            mainTabViewCoordinator: MainTabViewCoordinator.shared
        )
    }
    
    public func buildLoginView(
        rootCoordinator: RootViewCoordinator
    ) -> some View {
        LoginView(
            viewModel: LoginViewModel(
                coordinator: rootCoordinator
            )
        )
    }
    
    public func buildMainTabView(
        rootCoordinator: RootViewCoordinator,
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        MainTabView(
            viewModel: MainTabViewModel(
                rootViewCoordinator: rootCoordinator,
                mainTabViewCoordinator: tabCoordinator
            )
        )
    }
    
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
    
    public func buildHomeView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        HomeView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: HomeViewModel()
        )
    }
    
    public func buildRaceScheduleView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        ScheduleSegmentedView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: ScheduleSegmentedViewModel()
        )
    }
    
    public func buildStandingsView(
        tabCoordinator: MainTabViewCoordinator
    ) -> some View {
        StandingsView(
            mainTabViewCoordinator: tabCoordinator,
            viewModel: StandingsViewModel()
        )
    }
    
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
