import Foundation

struct Club: Codable, NamedIdentifiable {
    let clubID: Int
    let name: String
    var pfpURL: URL? = nil
    var school: School?  = nil
    
    var id: Int { clubID }
    
    static private var mockID: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case clubID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case school = "school_id"
    }
    
    static func mock() -> Club {
        mockID += 1
        
        return Club(clubID: mockID, name: "Test club", pfpURL: URL(string: "https://shorturl.at/vYd1A"))
    }
}

struct ClubDetails: Codable, NamedIdentifiable {
    let clubID: Int
    let name: String
    var pfpURL: URL? = nil
    var timeZone: String? = nil
    var auth0ID: String? = nil
    var school: School?  = nil
    
    var id: Int { clubID }
    
    static private var mockID: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case clubID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case timeZone = "time_zone"
        case auth0ID = "auth0_id"
        case school = "school_id"
    }
    
    static func mock() -> ClubDetails {
        mockID += 1
        
        return ClubDetails(
            clubID: mockID,
            name: "Test club",
            pfpURL: URL(string: "https://shorturl.at/vYd1A")
        )
    }
}

