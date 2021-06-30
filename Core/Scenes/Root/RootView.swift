//
//  RootView.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import SwiftUI

public struct RootView: View {
    @ObservedObject
    var rootViewCoordinator: RootViewCoordinator
    
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    public init(
        rootViewCoordinator: RootViewCoordinator,
        mainTabViewCoordinator: MainTabViewCoordinator
    ) {
        _rootViewCoordinator = ObservedObject(
            wrappedValue: rootViewCoordinator
        )
        _mainTabViewCoordinator = ObservedObject(
            wrappedValue: mainTabViewCoordinator
        )
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                switch rootViewCoordinator.selectedScreen {
                case .login:
                    LoginView(
                        viewModel: LoginViewModel(
                            coordinator: rootViewCoordinator
                        )
                    )
                case .mainTabView:
                    MainTabView(
                        viewModel: MainTabViewModel(
                            rootViewCoordinator: rootViewCoordinator,
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            rootViewCoordinator: RootViewCoordinator(),
            mainTabViewCoordinator: MainTabViewCoordinator()
        )
    }
}
