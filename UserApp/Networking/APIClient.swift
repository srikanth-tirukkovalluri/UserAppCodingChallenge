// UsersAPIClient.swift

import Foundation

struct APIClient: APIClientProvider {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable & Sendable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)
        
        // Validate HTTP status code
        if let httpResponse = response as? HTTPURLResponse,
           !(200..<300).contains(httpResponse.statusCode) {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
        
        // Decode JSON response
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
