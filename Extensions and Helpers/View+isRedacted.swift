//
//  View+isRedacted.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 27/05/2021.
//

import SwiftUI

extension View {
    @ViewBuilder func isRedacted(_ redacted: Bool) -> some View {
        if redacted {
            self.redacted(reason: .placeholder)
        } else {
            self.unredacted()
        }
    }
}
