//
//  SectionTitle.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 35.0, weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 5.0)
    }
}
