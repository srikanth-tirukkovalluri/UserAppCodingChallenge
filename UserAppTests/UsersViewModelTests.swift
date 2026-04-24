//
//  Untitled.swift
//  QantasCodeChallenge
//
//  Created by Micah Napier on 12/12/2025.
//

import XCTest
@testable import UserApp

@MainActor
final class UsersViewModelTests: XCTestCase {
    var sut: UsersViewModel!
    
    func test_initialState_isIdle() {
        sut = UsersViewModel(apiClient: MockAPIClient())
        guard case .idle = sut.state else { return XCTFail("Expected .idle") }
    }
    
    func test_load_success_transitionsToLoaded() async {
        let apiClient = MockAPIClient()
        apiClient.stubbedData = userJSON.data(using: .utf8)!
        sut = UsersViewModel(apiClient: apiClient)

        await sut.load()
        guard case .loaded(let users) = sut.state else { return XCTFail("Expected .loaded") }
        XCTAssertEqual(users.count, 1)
    }
    
    func test_load_failure_transitionsToFailed() async {
        let apiClient = MockAPIClient()
        apiClient.stubbedError = .requestFailed(statusCode: 500)
        sut = UsersViewModel(apiClient: apiClient)

        await sut.load()
        guard case .failed = sut.state else { return XCTFail("Expected .failed") }
    }
}
