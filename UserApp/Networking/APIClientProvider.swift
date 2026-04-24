//
//  APIClientProvider.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import Foundation

protocol APIClientProvider: Sendable {
    func fetch<T: Decodable & Sendable>(url: URL) async throws -> T
}
