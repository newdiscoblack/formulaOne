//
//  SettingsView.swift
//  Core
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI
import Utilities

struct SettingsView: View {
    @ObservedObject
    var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            SectionTitle(
                title: "Settings"
            )
            Button(action: {
                viewModel.logOut()
            }) {
                Text("Log out")
                    .foregroundColor(.white)
            }
            Spacer()
//            VStack {
//                Image("regularLogo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                Image("tvLogo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
//            Spacer()
        }
        .modifier(DefaultViewStyleModifier())
    }
}

#if DEBUG
struct SettingsView_PreviewContainer: View {
    var body: some View {
        SettingsView(
            viewModel: SettingsViewModel(
                mainAppCoordinator: MainAppCoordinator()
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
