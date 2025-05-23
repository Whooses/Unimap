import Foundation

struct NewUser: Codable, NamedIdentifiable {
    let userID: Int
    let name: String
    var pfpURL: URL? = nil
    let isVerified: Bool
    var timeZone: String? = nil
    var auth0ID: String? = nil
    var school: School?  = nil
    
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
