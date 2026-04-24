//
//  APIEndpointsTests.swift
//  UserApp
//
//  Created by Srikanth Chaitanya Tirukkovalluri on 24/4/2026.
//

import XCTest
@testable import UserApp

final class APIEndpointsTests: XCTestCase {
    func test_getUsers_endpoint()  {
        XCTAssertTrue(APIEndpoints.getUsers.url?.absoluteString == "https://jsonplaceholder.typicode.com/users")
    }
}
