import Foundation

struct Club: Codable, NamedIdentifiable {
    let clubID: UUID
    let name: String
    var pfpURL: URL? = nil
    let isVerified: Bool
    var school: School?  = nil
    
    var id: UUID { clubID }
    
    enum CodingKeys: String, CodingKey {
        case clubID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case isVerified = "is_verified"
        case school = "school_id"
    }
    
    static func mock() -> Club {
        return Club(clubID: UUID(), name: "Test club", pfpURL: URL(string: "https://shorturl.at/vYd1A"), isVerified: false)
    }
}

struct ClubDetails: Codable, NamedIdentifiable {
    let clubID: UUID
    let name: String
    var pfpURL: URL? = nil
    let isVerified: Bool
    var timeZone: String? = nil
    var auth0ID: String? = nil
    var school: School?  = nil
    
    var id: UUID { clubID }
    
    enum CodingKeys: String, CodingKey {
        case clubID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case isVerified = "is_verified"
        case timeZone = "time_zone"
        case auth0ID = "auth0_id"
        case school = "school_id"
    }
    
    static func mock() -> Club {
        return Club(clubID: UUID(), name: "Test User", pfpURL: URL(string: "https://shorturl.at/vYd1A"), isVerified: false)
    }
}

