//
//  MainTabView.swift
//  formula-one
//
//  Created by Kacper Jagiello on 08/04/2021.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                switch coordinator.selectedTab {
                case MainTab.home:
                    HomeView(
                        coordinator: coordinator,
                        viewModel: HomeViewModel()
                    )
                case MainTab.schedule:
                    ScheduleView()
                case MainTab.standings:
                    StandingsView(
                        coordinator: coordinator,
                        viewModel: StandingsViewModel()
                    )
                }
                Spacer()
                TabBar(coordinator: coordinator)
                    .alignmentGuide(.bottom) { dimension in
                        dimension[.bottom]
                    }
                    .isHidden(!coordinator.shouldDisplayTabBar)
            }
        }
        .background(Color.clear)
    }
}

#if DEBUG
struct HomeTabView_PreviewContainer: View {
    var body: some View {
        MainTabView(
            coordinator: MainTabViewCoordinator()
        )
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView_PreviewContainer()
    }
}
#endif

