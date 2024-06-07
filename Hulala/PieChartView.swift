//
//  PieChartView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//
import SwiftUI

struct PieChartView: View {
    var title: String
    var data: [PieChartDataEntry]
    var types: [TypeTransaction]  
    var innerRadiusRatio: CGFloat = 0.6 // Ratio pour le trou central

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .padding()

            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

                ZStack {
                    ForEach(data.indices, id: \.self) { index in
                        let startAngle = angle(for: index)
                        let endAngle = angle(for: index + 1)
                        let entry = data[index]
                        let color = types.first(where: { $0.name == entry.label })?.color ?? Color.gray
                        PieSliceView(startAngle: startAngle, endAngle: endAngle, color: color, innerRadiusRatio: innerRadiusRatio)
                            .frame(width: radius * 2, height: radius * 2)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .frame(height: 300)

            HStack {
                ForEach(uniqueCategories, id: \.self) { category in
                    let color = types.first(where: { $0.name == category })?.color ?? Color.gray
                    HStack {
                        Rectangle()
                            .fill(color)
                            .frame(width: 20, height: 20)
                        Text(category)
                            .font(.caption)
                    }
                }
            }
            .padding(.top)

            
        }
        .padding()
    }

    private func angle(for index: Int) -> Angle {
        let total = data.reduce(0) { $0 + $1.value }
        let startAngle = data.prefix(index).reduce(0) { $0 + $1.value } / total * 360 - 90
        return Angle(degrees: startAngle)
    }

    private var uniqueCategories: [String] {
        Array(Set(data.map { $0.label })).sorted()
    }

    private var total: Double {
        data.reduce(0) { $0 + $1.value }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(title: "Example", data: [
            PieChartDataEntry(value: 10, label: "Transport"),
            PieChartDataEntry(value: 20, label: "Housing"),
            PieChartDataEntry(value: 30, label: "Medical")
        ], types: [
            TypeTransaction(name: "Transport", color: .blue),
            TypeTransaction(name: "Housing", color: .green),
            TypeTransaction(name: "Medical", color: .red)
        ])
    }
}
