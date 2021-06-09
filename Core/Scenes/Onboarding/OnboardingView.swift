//
//  LoginView.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import SwiftUI

public struct OnboardingView: View {
    @ObservedObject
    var mainAppCoordinator: MainAppCoordinator
    
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    public init(
        mainAppCoordinator: MainAppCoordinator,
        mainTabViewCoordinator: MainTabViewCoordinator
    ) {
        self.mainAppCoordinator = mainAppCoordinator
        self.mainTabViewCoordinator = mainTabViewCoordinator
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                switch mainAppCoordinator.selectedTab {
                case .login:
                    LoginView(
                        viewModel: LoginViewModel(
                            coordinator: mainAppCoordinator
                        )
                    )
                case .mainTabView:
                    MainTabView(
                        viewModel: MainTabViewModel(
                            mainAppCoordinator: mainAppCoordinator,
                            mainTabViewCoordinator: mainTabViewCoordinator
                        )
                    )
                }
                Spacer()
            }
        }
        .background(Color.clear)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(
            mainAppCoordinator: MainAppCoordinator(),
            mainTabViewCoordinator: MainTabViewCoordinator()
        )
    }
}
