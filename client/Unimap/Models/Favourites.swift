import Foundation

struct Favourites: Codable {
    let user: User
    let event: Event
    
    enum CodingKeys: String, CodingKey {
        case user = "user_id"
        case event = "event_id"
    }
}
