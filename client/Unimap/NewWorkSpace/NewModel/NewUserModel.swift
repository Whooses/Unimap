import Foundation

struct NewUser: Codable, NamedIdentifiable {
    let userID: Int
    let name: String
    let pfpURL: URL?
    let isVerified: Bool
    let timeZone: String?
    let auth0ID: String?
    let school: School?
    
    var id: Int { userID }
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case isVerified = "is_verified"
        case timeZone = "time_zone"
        case auth0ID = "auth0_id"
        case school = "school_id"
    }
}
