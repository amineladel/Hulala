
//  Created by Amine LADEL on 23/05/2024.

import SwiftUI

struct SwipeableTransactionRow: View {
    let transaction: Transaction
    let deleteAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                Text(transaction.category)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(transaction.type == "Income" ? "+$\(transaction.amount, specifier: "%.2f")" : "-$\(transaction.amount, specifier: "%.2f")")
                .foregroundColor(transaction.type == "Income" ? .green : .red)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .swipeActions {
            Button(role: .destructive) {
                deleteAction()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

struct SwipeableTransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableTransactionRow(transaction: Transaction(title: "Test", amount: 10, type: "Expense", category: "Food", date: Date()), deleteAction: {})
    }
}
