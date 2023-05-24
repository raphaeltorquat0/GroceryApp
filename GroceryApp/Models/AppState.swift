//
//  AppState.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 24/05/23.
//

import Foundation

enum Route: Hashable {
    case login
    case register
    case groceryCategoryList
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
