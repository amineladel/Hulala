//
//  Extensions.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import Foundation

extension Date {
    func formatted(_ format: String = "dd MMMM") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Dictionary where Key == Date, Value == [Transaction] {
    static func groupTransactionsByDate(_ transactions: [Transaction]) -> [Date: [Transaction]] {
        var groupedTransactions = [Date: [Transaction]]()
        for transaction in transactions {
            let date = Calendar.current.startOfDay(for: transaction.date)
            if groupedTransactions[date] == nil {
                groupedTransactions[date] = [transaction]
            } else {
                groupedTransactions[date]?.append(transaction)
            }
        }
        return groupedTransactions
    }
}
