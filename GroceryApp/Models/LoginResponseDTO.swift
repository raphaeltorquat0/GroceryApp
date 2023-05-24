//
//  LoginRespondeDTO.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import Foundation

struct LoginResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
    let token: String?
    let userId: UUID
}
