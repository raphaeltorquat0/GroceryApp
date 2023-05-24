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
    var token: String? = nil
    var userId: UUID? = nil
}
