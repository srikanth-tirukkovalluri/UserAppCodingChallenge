//
//  APIClientTests.swift
//  UserAppTests
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import XCTest
@testable import UserApp

final class APIClientTests: XCTestCase {
    private let url = URL(string: "https://example.com")!

    private func mockSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }

    private func stub(status: Int, body: String) {
        MockURLProtocol.handler = { [url] _ in
            (HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: nil)!, Data(body.utf8))
        }
    }

    override func tearDown() { MockURLProtocol.handler = nil }

    func test_fetch_200_returnsDecodedUsers() async throws {
        stub(status: 200, body: userJSON)
        let users: [User] = try await APIClient(session: mockSession()).fetch(url: url)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users[0].name, "Alice")
    }

    func test_fetch_nonSuccess_throwsRequestFailed() async throws {
        stub(status: 404, body: "")
        
        do {
            _ = try await APIClient(session: mockSession()).fetch(url: url) as [User]
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .requestFailed(let code) = error else {
                XCTFail("Expected NetworkError.requestFailed")
                return
            }
            XCTAssertEqual(code, 404)
        } catch {
            XCTFail("Expected NetworkError but got \(error)")
        }
    }

    func test_fetch_badJSON_throwsDecodingError() async throws {
        stub(status: 200, body: "not json")
        
        do {
            _ = try await APIClient(session: mockSession()).fetch(url: url) as [User]
            XCTFail("Expected error to be thrown")
        } catch let error as NetworkError {
            guard case .decodingError = error else {
                XCTFail("Expected NetworkError.decodingError")
                return
            }
        } catch {
            XCTFail("Expected NetworkError but got \(error)")
        }
    }
}
