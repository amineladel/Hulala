//
//  HomeView.swift
//  Hulala
//
//  Created par Amine LADEL on 23/05/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var transactionStore: TransactionStore
    @State private var showingAddExpenseView = false

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color.blue
                        .edgesIgnoringSafeArea(.top)
                    VStack {
                        // Calculer le solde total, les revenus et les dépenses
                        let totalBalance = transactionStore.transactions.reduce(0) { $0 + ($1.type == "Income" ? $1.amount : -$1.amount) }
                        let totalIncome = transactionStore.transactions.filter { $0.type == "Income" }.reduce(0) { $0 + $1.amount }
                        let totalExpense = transactionStore.transactions.filter { $0.type == "Expense" }.reduce(0) { $0 + $1.amount }

                        Text("\(totalBalance, specifier: "%.0f") €")
                            .font(.system(size: 40, weight: .bold))
                            .padding()
                            .foregroundColor(.white) // Pour que le texte soit visible sur le fond bleu

                        HStack {
                            VStack {
                                Text("Virements")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Text("\(totalIncome, specifier: "%.0f") €")
                                    .foregroundColor(.green)
                                    .font(.title2)
                            }
                            .padding()

                            VStack {
                                Text("Paiements")
                                    .foregroundColor(.white)
                                    .font(.title)
                                Text("\(totalExpense, specifier: "%.0f") €")
                                    .foregroundColor(.red)
                                    .font(.title2)
                            }
                            .padding()
                        }
                    }
                    .padding(.vertical, 20) // Ajuster pour réduire la taille de la section bleue
                }
                .frame(height: UIScreen.main.bounds.height / 4) // Faire en sorte que la section prenne environ un tiers de la taille de l'écran

                List {
                    ForEach(groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                        Section(header: Text(date.formattedAsDate()).font(.headline)) {
                            ForEach(groupedTransactions[date]!) { transaction in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(transaction.title)
                                        Text(transaction.category)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text(transaction.type == "Income" ? "+ \(transaction.amount, specifier: "%.0f") €" : "- \(transaction.amount, specifier: "%.0f") €")
                                        .foregroundColor(transaction.type == "Income" ? .green : .red)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    if let transactionToDelete = groupedTransactions[date]?[index] {
                                        transactionStore.transactions.removeAll { $0.id == transactionToDelete.id }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .toolbar {
                Button(action: {
                    showingAddExpenseView.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showingAddExpenseView) {
                AddExpenseView(transactionStore: transactionStore)
            }
        }
    }

    private var groupedTransactions: [Date: [Transaction]] {
        Dictionary.groupTransactionsByDate(transactionStore.transactions)
    }
}

extension Date {
    func formattedAsDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(transactionStore: TransactionStore())
    }
}
