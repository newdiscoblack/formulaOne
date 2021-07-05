//
//  View+isHidden.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 27/05/2021.
//

import SwiftUI

extension View {
    @ViewBuilder
    public func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

