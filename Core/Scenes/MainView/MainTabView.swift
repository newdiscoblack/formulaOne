//
//  MainTabView.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import SwiftUI

public struct MainTabView: View {
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    @StateObject
    var viewModel: MainTabViewModel
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                switch viewModel.mainTabViewCoordinator.selectedTab {
                case MainTab.home:
                    dependencies
                        .viewFactory
                        .buildHomeView(
                            tabCoordinator: viewModel.mainTabViewCoordinator
                        )
                case MainTab.schedule:
                    dependencies
                        .viewFactory
                        .buildRaceScheduleView(
                            tabCoordinator: viewModel.mainTabViewCoordinator
                        )
                case MainTab.standings:
                    dependencies
                        .viewFactory
                        .buildStandingsView(
                            tabCoordinator: viewModel.mainTabViewCoordinator
                        )
                case MainTab.settings:
                    dependencies
                        .viewFactory
                        .buildSettingsView(
                            rootCoordinator: viewModel.rootViewCoordinator
                        )
                }
                Spacer()
                dependencies
                    .viewFactory
                    .buildTabBar(
                        tabCoordinator: viewModel.mainTabViewCoordinator
                    )
            }
        }
        .background(Color.clear)
    }
}

#if DEBUG
struct HomeTabView_PreviewContainer: View {
    var body: some View {
        MainTabView(
            viewModel: MainTabViewModel(
                rootViewCoordinator: RootViewCoordinator.shared,
                mainTabViewCoordinator: MainTabViewCoordinator.shared
            )
        )
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView_PreviewContainer()
    }
}
#endif

