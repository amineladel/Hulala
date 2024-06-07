//
//  AddEditTypeView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

struct AddEditTypeView: View {
    @EnvironmentObject var transactionStore: TransactionStore
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var color: Color = .blue
    @State private var typeToEdit: TypeTransaction?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Détails")) {
                    TextField("Nom", text: $name)
                    ColorPicker("Couleur", selection: $color)
                }
                
                Button(action: {
                    if let typeToEdit = typeToEdit {
                        let updatedType = TypeTransaction(id: typeToEdit.id, name: name, color: color)
                        transactionStore.updateType(updatedType)
                    } else {
                        let newType = TypeTransaction(name: name, color: color)
                        transactionStore.addType(newType)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(typeToEdit != nil ? "Update Type" : "Ajouter")
                }
            }
            .navigationBarTitle(typeToEdit != nil ? "Edit Type" : "Ajouter une catégorie", displayMode: .inline)
            .navigationBarItems(trailing: Button("Retour") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddEditTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditTypeView()
            .environmentObject(TransactionStore())
    }
}

