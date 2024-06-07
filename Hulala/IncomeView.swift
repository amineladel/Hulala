//
//  IncomeView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

struct IncomeView: View {
    @ObservedObject var transactionStore: TransactionStore

    var body: some View {
        NavigationView {
            VStack {
                PieChartView(title: "Virements", data: incomeData, types: transactionStore.types)
                    .frame(height: 400)

                List {
                    ForEach(groupedIncomeTransactions.keys.sorted(by: >), id: \.self) { date in
                        Section(header: Text(date.formattedAsDate()).font(.headline)) {
                            ForEach(groupedIncomeTransactions[date]!) { transaction in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(transaction.title)
                                        Text(transaction.category)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("+ \(transaction.amount, specifier: "%.0f") €")
                                        .foregroundColor(.green)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    if let transactionToDelete = groupedIncomeTransactions[date]?[index] {
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

    private var incomeData: [PieChartDataEntry] {
        transactionStore.transactions
            .filter { $0.type == "Income" }
            .map { PieChartDataEntry(value: $0.amount, label: $0.category) }
    }

    private var groupedIncomeTransactions: [Date: [Transaction]] {
        Dictionary.groupTransactionsByDate(transactionStore.transactions.filter { $0.type == "Income" })
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView(transactionStore: TransactionStore())
    }
}

