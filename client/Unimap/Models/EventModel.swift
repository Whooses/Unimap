import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let date: String              // maps to "date"
    let location: String?
    let imageURL: URL?             // maps to "image_url"
    let isPublic: Bool?            // maps to "is_public"
    let createdAt: String          // maps to "created_at"
    let updatedAt: String?         // maps to "updated_at"
    let username: String?          // maps to "username"
    let departments: [String]?
    let categories: [String]?
    let clubs: [String]?
    let types: [String]?
    let ownerId: Int               // maps to "owner_id"
    let userId: Int                // maps to "user_id"
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, title, description, date, location
        case imageURL   = "image_url"
        case isPublic   = "is_public"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
        case username, departments, categories, clubs, types
        case ownerId    = "owner_id"
        case userId     = "user_id"
        case user
    }
}
