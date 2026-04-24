// UsersViewModel.swift

import Foundation
import Combine

enum UsersState {
    case idle
    case loading
    case loaded([User])
    case failed(Error)
}

@Observable
@MainActor
final class UsersViewModel {
    private(set) var state: UsersState = .idle

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func load() async {
        state = .loading

        do {
            guard let url = APIEndpoints.getUsers.url else {
                throw NetworkError.invalidURL
            }
            
            let users: [User] = try await apiClient.fetch(url: url)
            state = .loaded(users)
        } catch {
            state = .failed(error)
            print("Error fetching users: \(error)")
        }
    }
}
