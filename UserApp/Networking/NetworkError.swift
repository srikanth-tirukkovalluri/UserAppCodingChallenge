//
//  NetworkError.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .requestFailed(let code):
            return "The request failed with status code \(code)."
        case .decodingError:
            return "The server response could not be decoded."
        }
    }
}
