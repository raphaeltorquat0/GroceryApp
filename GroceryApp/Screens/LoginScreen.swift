//
//  LoginScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            if loginResponseDTO.error {
                errorMessage = loginResponseDTO.reason ?? ""
            } else {
                appState.routes.append(.groceryCategoryList)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }.buttonStyle(.borderless).disabled(!isFormValid)
            }
            Text(errorMessage)
        }.navigationTitle("Login")
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
    }
}

