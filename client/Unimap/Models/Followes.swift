import Foundation

struct follows: Codable {
    let user: User
    let follower: User
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case user = "user_id"
        case follower = "follower_id"
        case createdAt = "created_at"
    }
}

