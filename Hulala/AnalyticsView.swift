//
//  AnalyticsView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//


import SwiftUI

struct AnalyticsView: View {
    @ObservedObject var transactionStore: TransactionStore

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Graphiques")
                        .font(.largeTitle)
                        .padding()

                    PieChartView(title: "Virement", data: incomeData, types: transactionStore.types)
                    PieChartView(title: "Paiement", data: expenseData, types: transactionStore.types)
                }
                .padding()
            }
        }
    }

    private var incomeData: [PieChartDataEntry] {
        transactionStore.transactions
            .filter { $0.type == "Income" }
            .map { PieChartDataEntry(value: $0.amount, label: $0.category) }
    }

    private var expenseData: [PieChartDataEntry] {
        transactionStore.transactions
            .filter { $0.type == "Expense" }
            .map { PieChartDataEntry(value: $0.amount, label: $0.category) }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView(transactionStore: TransactionStore())
    }
}
