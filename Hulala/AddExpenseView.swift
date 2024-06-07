//
//  AddExpenseView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//
import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var transactionStore: TransactionStore
    @Environment(\.presentationMode) var presentationMode

    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var type: String = "Income"
    @State private var selectedCategory: TypeTransaction? = nil
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Détails Transaction")) {
                    TextField("Titre", text: $title)
                    TextField("Montant", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Type", selection: $type) {
                        Text("Virement").tag("Income")
                        Text("Paiement").tag("Expense")
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Catégorie", selection: $selectedCategory) {
                        Text("Sélectionner").tag(nil as TypeTransaction?)
                        ForEach(transactionStore.types, id: \.self) { category in
                            Text(category.name).tag(category as TypeTransaction?)
                        }
                    }

                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Button(action: {
                    if let amount = Double(amount), let selectedCategory = selectedCategory {
                        let transaction = Transaction(title: title, amount: amount, type: type, category: selectedCategory.name, date: date)
                        transactionStore.addTransaction(transaction)
                        resetForm()
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Ajouter")
                }
            }
            .navigationBarTitle("Ajouter une transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Retour") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private func resetForm() {
        title = ""
        amount = ""
        type = "Income"
        selectedCategory = nil
        date = Date()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(transactionStore: TransactionStore())
    }
}
