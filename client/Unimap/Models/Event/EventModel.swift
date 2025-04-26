import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    let ownerId: Int?        // maps "owner_id"
    let userId: Int?         // maps "user"
    let title: String
    let description: String
    let imageURL: URL?       // maps "image_url"
    let createdAt: String    // maps "created_at"
    let updatedAt: String?   // maps "updated_at"
    let location: String
    let date: String
    let isPublic: Bool       // maps "is_public"
    let username: String?    // optional if missing

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId   = "owner_id"
        case userId    = "user"
        case title
        case description
        case imageURL   = "image_url"
        case createdAt  = "created_at"
        case updatedAt  = "updated_at"
        case location
        case date
        case isPublic   = "is_public"
        case username
    }
}
