//
//  User.swift
//  InterviewTestApp
//
//  Created by Hari Rait on 19.03.24.
//

import Foundation

struct APIResponse: Codable {
    let data: [APIUser]
}

struct APIUser: Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}

struct TestUser: Identifiable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
