//
//  MockAPIClient.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import Foundation
@testable import UserApp

final class MockAPIClient: APIClientProvider, @unchecked Sendable {
    private(set) var capturedURL: URL?
    var stubbedData = Data()
    var stubbedError: NetworkError?

    func fetch<T: Decodable & Sendable>(url: URL) async throws -> T {
        capturedURL = url
        if let e = stubbedError { throw e }
        return try JSONDecoder().decode(T.self, from: stubbedData)
    }
}
