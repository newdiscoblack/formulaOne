//
//  SectionTitle.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    let color: Color
    
    public init(
        title: String,
        color: Color = .white
    ) {
        self.title = title
        self.color = color
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 35.0, weight: .semibold))
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 5.0)
    }
}
