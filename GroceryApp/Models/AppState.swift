//
//  AppState.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 24/05/23.
//

import Foundation
import GroceryAppSharedDTO

enum Route: Hashable {
    case login
    case register
    case groceryCategoryList
    case groceryCategoryDetail(GroceryCategoryResponseDTO)
}

class AppState: ObservableObject {
    @Published var routes: [Route] = []
}
