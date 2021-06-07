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
                TabBarButton(
                    image: "house",
                    isSelected: coordinator.selectedTab == .home
                )
            }
            Spacer()
            Button(action: {
                coordinator.selectedTab = .schedule
            }) {
                TabBarButton(
                    image: "calendar.badge.clock",
                    isSelected: coordinator.selectedTab == .schedule
                )
            }
            Spacer()
            Button(action: {
                coordinator.selectedTab = .standings
            }) {
                TabBarButton(
                    image: "person.3",
                    isSelected: coordinator.selectedTab == .standings
                )
            }
            Spacer()
            Button(action: {
                coordinator.selectedTab = .settings
            }) {
                TabBarButton(
                    image: "gearshape",
                    isSelected: coordinator.selectedTab == .settings
                )
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background(Color.black)
        .clipShape(Capsule())
        .padding(.horizontal, 60)
    }
}

private struct TabBarButton: View {
    let imageName: String
    let isSelected: Bool
    
    init(
        image imageName: String,
        isSelected: Bool
    ) {
        self.imageName = imageName
        self.isSelected = isSelected
    }
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 25.0))
            .foregroundColor(
                isSelected ?
                    .red
                    : .gray
            )
    }
}
