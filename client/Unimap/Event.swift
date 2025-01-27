//
//  Event.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-27.
//


import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let image_url: String
    let created_at: String
    let location: String
    let date: String
    let user: Int
    let is_public: Bool
    let updated_at: String?
    let username: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case image_url
        case created_at
        case location
        case date
        case user
        case is_public
        case updated_at
        case username
    }
}
