//
//  Transaction.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let type: String
    let category: String
    let date: Date
}

