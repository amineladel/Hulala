//
//  TransactionStore.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

class TransactionStore: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var types: [TypeTransaction] = [
        TypeTransaction(name: "Salaire", color: .blue),
        TypeTransaction(name: "Virement entrant", color: .green),
        TypeTransaction(name: "Nourriture", color: .red),
        TypeTransaction(name: "Loisirs", color: .purple)
        // Ajoutez des types par défaut ici
    ]

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }

    func removeTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }

    func addType(_ type: TypeTransaction) {
        types.append(type)
    }

    func removeType(at offsets: IndexSet) {
        types.remove(atOffsets: offsets)
    }

    func updateType(_ type: TypeTransaction) {
        if let index = types.firstIndex(where: { $0.id == type.id }) {
            types[index] = type
        }
    }
}

