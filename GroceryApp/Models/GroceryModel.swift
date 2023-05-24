//
//  GroceryModel.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import Foundation

class GroceryModel: ObservableObject {
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        let registerData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        let loginData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginData)), modelType: LoginResponseDTO.self)
        let loginResponseDTO = try await httpClient.load(resource)
        
        
        guard case loginResponseDTO.token = loginResponseDTO.token, case loginResponseDTO.userId?.uuidString = loginResponseDTO.userId?.uuidString else { return loginResponseDTO }
            
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token, forKey: "authToken")
            defaults.set(loginResponseDTO.userId?.uuidString, forKey: "userId")
            return loginResponseDTO
        
    }
}
