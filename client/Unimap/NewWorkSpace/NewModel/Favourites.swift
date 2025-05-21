import Foundation

struct Favourites: Codable {
    let user: NewUser
    let event: NewEvent
    
    enum CodingKeys: String, CodingKey {
        case user = "user_id"
        case event = "event_id"
    }
}
