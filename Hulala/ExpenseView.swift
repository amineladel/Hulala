//
//  ExpenseView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//


import SwiftUI

struct ExpenseView: View {
    @ObservedObject var transactionStore: TransactionStore

    var body: some View {
        NavigationView {
            VStack {
                PieChartView(title: "Paiements", data: expenseData, types: transactionStore.types)
                    .frame(height: 400)

                List {
                    ForEach(groupedExpenseTransactions.keys.sorted(by: >), id: \.self) { date in
                        Section(header: Text(date.formattedAsDate()).font(.headline)) {
                            ForEach(groupedExpenseTransactions[date]!) { transaction in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(transaction.title)
                                        Text(transaction.category)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("-\(transaction.amount, specifier: "%.0f") €")
                                        .foregroundColor(.red)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    if let transactionToDelete = groupedExpenseTransactions[date]?[index] {
                                        transactionStore.transactions.removeAll { $0.id == transactionToDelete.id }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    }

    private var expenseData: [PieChartDataEntry] {
        transactionStore.transactions
            .filter { $0.type == "Expense" }
            .map { PieChartDataEntry(value: $0.amount, label: $0.category) }
    }

    private var groupedExpenseTransactions: [Date: [Transaction]] {
        Dictionary.groupTransactionsByDate(transactionStore.transactions.filter { $0.type == "Expense" })
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(transactionStore: TransactionStore())
    }
}

