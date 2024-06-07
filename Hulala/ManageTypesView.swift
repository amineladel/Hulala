//
//  ManageTypesView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.
//

import SwiftUI

struct ManageTypesView: View {
    @EnvironmentObject var transactionStore: TransactionStore
    @State private var showingAddTypeView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(transactionStore.types) { type in
                    HStack {
                        Circle()
                            .fill(type.color)
                            .frame(width: 20, height: 20)
                        Text(type.name)
                    }
                }
                .onDelete(perform: transactionStore.removeType)
            }
            .navigationBarTitle("Catégories")
            .navigationBarItems(trailing: Button(action: {
                showingAddTypeView.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTypeView) {
                AddEditTypeView()
                    .environmentObject(transactionStore)
            }
        }
    }
}

struct ManageTypesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageTypesView()
            .environmentObject(TransactionStore())
    }
}

