//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10) && !email.isEmptyOrWhiteSpace
    }
    
    
    private func register() async {
        do {
            let registerResponseDTO = try await model.register(username: username, password: password, email: email)
            if !registerResponseDTO.error {
                /* take user to the login screen */
                
            } else {
                errorMessage = registerResponseDTO.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    
    var body: some View {
        Form {
            TextField("Username", text: $username).textInputAutocapitalization(.never)
            SecureField("Password", text: $password).textInputAutocapitalization(.never)
            TextField("Email", text: $email).textInputAutocapitalization(.never)
            
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
                
            }
            Text(errorMessage)
        }
        .navigationTitle("Registration")
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationScreen().environmentObject(GroceryModel())
        }
    }
}
