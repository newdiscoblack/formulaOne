//
//  ScheduleView.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
        VStack {
            Text("Default text")
                .padding(.vertical, 100)
            Text("another text")
            Spacer()
        }
    }
}

#if DEBUG
struct ScheduleView_PreviewContainer: View {
    var body: some View {
        ScheduleView()
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView_PreviewContainer()
    }
}
#endif
