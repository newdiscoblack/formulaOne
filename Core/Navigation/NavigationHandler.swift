//
//  NavigationHandler.swift
//  Core
//
//  Created by Kacper Jagiełło on 30/06/2021.
//

import Combine
import SwiftUI

struct NavigationHandler: ViewModifier {
    @State
    private var destination: NavigationDestination?
    
    @State
    private var isPushing = false
    
    @State
    private var isPresenting = false
    
    @Environment(\.appDependencies)
    var dependencies: AppDependenciesProtocol
    
    @Environment(\.presentationMode)
    private var presentation

    let navigationPublisher: AnyPublisher<NavigationDirection, Never>
    
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: $isPresenting
            ) {
                buildDestination()
            }
            .background(
                NavigationLink(
                    destination: buildDestination(),
                    isActive: $isPushing
                ) {
                    EmptyView()
                }
            )
            .onReceive(navigationPublisher) { direction in
                switch direction {
                case .navigate(let destination, let style):
                    self.destination = destination
                    switch style {
                    case .present:
                        isPresenting = true
                    case .push:
                        isPushing = true
                    }
                case .dismiss:
                    presentation.wrappedValue.dismiss()
                }
            }
    }
    
    @ViewBuilder
    private func buildDestination() -> some View {
        if let destination = destination {
            dependencies
                .viewFactory
                .buildDestination(destination)
        } else {
            EmptyView()
        }
    }
}


