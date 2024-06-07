//
//  AuthenticationView.swift
//  Hulala
//
//  Created by Ben Salah on 07/06/2024.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @State private var isUnlocked = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        Group {
            if isUnlocked {
                ContentView()
            } else {
                Text("Veuillez vous authentifier pour accéder à l'application.")
                    .onAppear(perform: authenticate)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Échec de l'authentification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Veuillez vous authentifier pour accéder à l'application."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.alertMessage = authenticationError?.localizedDescription ?? "Erreur inconnue"
                        self.showAlert = true
                    }
                }
            }
        } else {
            self.alertMessage = error?.localizedDescription ?? "Biométrie non disponible"
            self.showAlert = true
        }
    }
}

