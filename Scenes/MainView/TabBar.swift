//
//  TabBar.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import SwiftUI

struct TabBar: View {
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    var body: some View {
        HStack {
            Button(action: {
                coordinator.selectedTab = .home
            }) {
                Image(systemName: "house")
                    .font(.system(size: 25))
                    .foregroundColor(
                        coordinator.selectedTab == .home ?
                            .white
                            : .gray
                    )
            }
            .foregroundColor(.white)
            Spacer()
            Button(action: {
                coordinator.selectedTab = .schedule
            }) {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: 25))
                    .foregroundColor(
                        coordinator.selectedTab == .schedule ?
                            .white
                            : .gray
                    )
            }
            .foregroundColor(.white)
            Spacer()
            Button(action: {
                coordinator.selectedTab = .standings
            }) {
                Image(systemName: "person.3")
                    .font(.system(size: 25))
                    .foregroundColor(
                        coordinator.selectedTab == .standings ?
                            .white
                            : .gray
                    )
            }
            .foregroundColor(.white)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(Color.black)
        .clipShape(Capsule())
        .padding(.horizontal, 60)
    }
}
