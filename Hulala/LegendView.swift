//
//  LegendView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

struct LegendView: View {
    var color: Color
    var label: String

    var body: some View {
        HStack {
            Rectangle()
                .fill(color)
                .frame(width: 20, height: 20)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendView(color: .blue, label: "Transport")
    }
}
