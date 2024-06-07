//
//  PieSliceView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//


import SwiftUI

struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    var innerRadiusRatio: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2
            let innerRadius = radius * innerRadiusRatio
            
            Path { path in
                path.move(to: center)
                path.addArc(center: center, radius: innerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                path.addLine(to: CGPoint(x: center.x + radius * Foundation.cos(endAngle.radians), y: center.y + radius * Foundation.sin(endAngle.radians)))
                path.addArc(center: center, radius: radius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
                path.addLine(to: CGPoint(x: center.x + innerRadius * Foundation.cos(startAngle.radians), y: center.y + innerRadius * Foundation.sin(startAngle.radians)))
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}

struct PieSliceView_Previews: PreviewProvider {
    static var previews: some View {
        PieSliceView(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), color: .blue, innerRadiusRatio: 0.5)
            .frame(width: 100, height: 100)
    }
}
