//
//  NetworkError+Extensions.swift
//  GroceryApp
//
//  Created by Raphael Torquato on 23/05/23.
//

import Foundation

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Unable to perform request", comment: "badRequestError")
        case .ServerError(let errorMessage):
            return NSLocalizedString(errorMessage, comment: "serverError")
        case .decodingError:
            return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
        case .invalidResponse:
            return NSLocalizedString("Invalid respose", comment: "invalidResponse")
        }
    }
}
