//
//  APIEndpoints.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import Foundation

enum APIEndpoints {
    case getUsers
    
    var url: URL? {
        switch self {
        case .getUsers:
            return URL(string: "https://jsonplaceholder.typicode.com/users")
        }
    }
}
