//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 20/05/23.
//

import SwiftUI

@main
struct GroceryAppApp: App {
    
    @StateObject private var model = GroceryModel()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegistrationScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .register:
                            RegistrationScreen()
                        case .login:
                            LoginScreen()
                        case .groceryCategoryList:
                            Text("Grocery Category List is coming.")
                        }
                    }
            }.environmentObject(model)
            .environmentObject(appState)
        }
    }
}
