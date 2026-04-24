//
//  NetworkErrorTests.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import XCTest
@testable import UserApp

final class NetworkErrorTests: XCTestCase {
    func test_error_descriptions()  {
        XCTAssertTrue(NetworkError.invalidURL.errorDescription == "The request URL is invalid.")
        XCTAssertTrue((NetworkError.requestFailed(statusCode: 404).errorDescription == "The request failed with status code 404."))
        XCTAssertTrue(NetworkError.decodingError(NSError(domain: "", code: 0)).errorDescription == "The server response could not be decoded.")
    }
}
