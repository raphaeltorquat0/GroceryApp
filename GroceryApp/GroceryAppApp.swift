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
    
    var body: some Scene {
        WindowGroup {
            RegistrationScreen()
                .environmentObject(GroceryModel())
        }
    }
}
