// User.swift

import Foundation

nonisolated
struct User: Decodable, Identifiable, Sendable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}
