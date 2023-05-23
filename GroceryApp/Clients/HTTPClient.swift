//
//  HTTPClient.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import Foundation


enum NetworkError: Error {
    case badRequest
    case ServerError(String)
    case decodingError
    case invalidResponse
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var modelType: T.Type
}


struct HTTPClient {
    
}

