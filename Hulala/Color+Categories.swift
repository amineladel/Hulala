//
//  Color+Categories.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

extension Color {
    static func color(for category: String) -> Color {
        switch category {
        case "Transport":
            return .blue
        case "Housing":
            return .green
        case "Medical":
            return .red
        case "Entertainment":
            return .purple
        // Ajoutez d'autres catégories et leurs couleurs ici
        default:
            return .gray
        }
    }
}
