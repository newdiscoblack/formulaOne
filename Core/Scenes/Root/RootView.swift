//
//  RootView.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import SwiftUI

public struct RootView: View {
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    @ObservedObject
    var rootViewCoordinator: RootViewCoordinator
    
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @State
    var displayableError: DisplayableError?
    
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
            if let displayableError = displayableError {
                AlertView(
                    displayableError: displayableError
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.displayableError = nil
                    }
                }
            }
            Spacer()
        }
        .onReceive(dependencies.errorPresenter.$displayableError) { error in
            guard let error = error else { return }
            displayableError = error
        }
    }
}

struct AlertView: View {
    let displayableError: DisplayableError
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5.0) {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("Error:")
                }
                .font(
                    .system(
                        size: 16.0,
                        weight: .bold,
                        design: .default
                    )
                )
                Text(displayableError.localizedDescription)
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10.0)
            .frame(maxWidth: .infinity, minHeight: 80)
            .foregroundColor(.white)
            .padding()
            Spacer()
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            rootViewCoordinator: RootViewCoordinator.shared,
            mainTabViewCoordinator: MainTabViewCoordinator.shared
        )
    }
}
#endif

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}
