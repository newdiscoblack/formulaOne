//
//  SettingsView.swift
//  Core
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI
import Utilities

struct SettingsView: View {
    @StateObject
    var viewModel: SettingsViewModel
    
    init(
        viewModel: SettingsViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SectionTitle(
                    title: "Settings"
                )
                ForEach(viewModel.availableSettings.indices) { setting in
                    SettingsButton(
                        viewModel: viewModel,
                        setting: viewModel.availableSettings[setting]
                    )
                }
                Spacer()
            }
            .navigationBarTitle("Settings")
            .navigationBarHidden(true)
            .modifier(DefaultViewStyleModifier())
            .handleNavigation(viewModel.navigationPublisher)
        }
    }
}

struct SettingsButton: View {
    @ObservedObject
    var viewModel: SettingsViewModel
    
    let setting: SettingsOption

    var body: some View {
        Button(action: {
            setting.action()
            viewModel.navigate(to: setting)
        }) {
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
        }
    }
}

#if DEBUG
struct SettingsView_PreviewContainer: View {
    var body: some View {
        SettingsView(
            viewModel: SettingsViewModel(
                rootViewCoordinator: RootViewCoordinator.shared
            )
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView_PreviewContainer()
    }
}
#endif
