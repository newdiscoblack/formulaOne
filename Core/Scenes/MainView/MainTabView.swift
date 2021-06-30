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
                    HomeView(
                        mainTabViewCoordinator: viewModel.mainTabViewCoordinator,
                        viewModel: HomeViewModel()
                    )
                case MainTab.schedule:
                    ScheduleSegmentedView(
                        mainTabViewCoordinator: viewModel.mainTabViewCoordinator,
                        viewModel: ScheduleSegmentedViewModel()
                    )
                case MainTab.standings:
                    StandingsView(
                        mainTabViewCoordinator: viewModel.mainTabViewCoordinator,
                        viewModel: StandingsViewModel()
                    )
                case MainTab.settings:
                    SettingsView(
                        viewModel: SettingsViewModel(
                            rootViewCoordinator: viewModel.rootViewCoordinator
                        ),
                        onRoute: { route in
                            switch route {
                            case .profile:
                                Text("profile")
                            case .logout:
                                EmptyView()
                            }
                        }
                    )
                }
                Spacer()
                TabBar(coordinator: viewModel.mainTabViewCoordinator)
                    .alignmentGuide(.bottom) { dimension in
                        dimension[.bottom]
                    }
                    .isHidden(
                        !viewModel
                            .mainTabViewCoordinator
                            .shouldDisplayTabBar
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
                rootViewCoordinator: RootViewCoordinator(),
                mainTabViewCoordinator: MainTabViewCoordinator()
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

