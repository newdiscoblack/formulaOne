//
//  SettingsView.swift
//  Core
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI
import Utilities

struct SettingsView<Destination: View>: View {
    @StateObject
    var viewModel: SettingsViewModel
    
    @State
    var onRoute: (SettingsOption) -> Destination
    
    init(
        viewModel: SettingsViewModel,
        @ViewBuilder onRoute: @escaping (SettingsOption) -> Destination
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _onRoute = State(wrappedValue: onRoute)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SectionTitle(
                    title: "Settings"
                )
                ForEach(viewModel.availableSettings.indices) { setting in
                    SettingsButton(
                        setting: viewModel.availableSettings[setting],
                        onRoute: onRoute
                    )
                }
                Spacer()
            }
            .navigationBarTitle("Settings")
            .navigationBarHidden(true)
            .modifier(DefaultViewStyleModifier())
        }
    }
}

struct SettingsButton<Destination: View>: View {
    @State
    private var willPresent = false
    
    let setting: SettingsOption
    
    var onRoute: (SettingsOption) -> Destination
    
    var body: some View {
        NavigationLink(
            destination: onRoute(setting),
            isActive: $willPresent
        ) {
            HStack {
                setting.icon
                setting.title
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .foregroundColor(.white)
            .padding()
            .onTapGesture {
                setting.action()
                willPresent = true
            }
        }
    }
}

#if DEBUG
struct SettingsView_PreviewContainer: View {
    var body: some View {
        SettingsView(
            viewModel: SettingsViewModel(
                rootViewCoordinator: RootViewCoordinator()
            ),
            onRoute: { _ in }
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView_PreviewContainer()
    }
}
#endif
