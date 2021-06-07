//
//  DefaultViewStyleModifier.swift
//  Utilities
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI

public struct DefaultViewStyleModifier: ViewModifier {
    public init() { }
    public func body(content: Content) -> some View {
        content
            .frame(
                maxWidth: UIScreen.main.bounds.width
            )
            .background(
                Color.init(
                    red: 30/255,
                    green: 30/255,
                    blue: 30/255
                )
                .ignoresSafeArea()
          )
      }
}
