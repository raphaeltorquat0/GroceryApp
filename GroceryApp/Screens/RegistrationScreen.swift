//
//  RegistrationScreen.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    private func register() async {
        
        do {
            let registerResponseDTO = try await model.register(username: username, password: password)
            if !registerResponseDTO.error {
                appState.routes.append(.login)
                
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
            
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }.buttonStyle(.borderless)
                    .disabled(!isFormValid)
                Spacer()
                Button("Login") {
                    appState.routes.append(.login)
                }.buttonStyle(.borderless)
            }
            Text(errorMessage)
        }
        .navigationTitle("Registration")
    }
}

struct RegistrationScreenContainerView: View {
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some View {
        NavigationStack(path: $appState.routes) {
            RegistrationScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .register:
                        RegistrationScreen()
                    case .login:
                        LoginScreen()
                    case .groceryCategoryList:
                        Text("Grocery Category List is comming.")
                    }
                }
        }
        .environmentObject(model)
        .environmentObject(appState)
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreenContainerView()
    }
}
