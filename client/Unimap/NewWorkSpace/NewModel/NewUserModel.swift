import Foundation

struct NewUser: Codable {
    let userID: Int
    let username: String
    let pfpURL: URL?
    let school: School
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case username
        case pfpURL = "pfp_url"
        case school = "school_id"
    }
}
