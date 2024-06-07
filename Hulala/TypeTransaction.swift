//
//  TypeTransaction.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import Foundation
import SwiftUI 


struct TypeTransaction: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var color: Color

    static func == (lhs: TypeTransaction, rhs: TypeTransaction) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
