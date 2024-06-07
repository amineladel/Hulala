//
//  ContentView.swift
//  Hulala
//
//  Created by Amine LADEL on 23/05/2024.

import SwiftUI

struct ContentView: View {
    @StateObject var transactionStore = TransactionStore()

    var body: some View {
        TabView {
            HomeView(transactionStore: transactionStore)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Accueil")
                }

            IncomeView(transactionStore: transactionStore)
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Virements")
                }

            ExpenseView(transactionStore: transactionStore)
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Paiements")
                }

            ManageTypesView()
                .environmentObject(transactionStore)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Catégories")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
