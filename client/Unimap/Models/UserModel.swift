import Foundation

struct User: Codable, NamedIdentifiable {
    let userID: Int
    let name: String
    var pfpURL: URL? = nil
    let isVerified: Bool
    var school: School?  = nil
    
    var id: Int { userID }
    
    private static var mockIDCounter: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case isVerified = "is_verified"
        case school = "school_id"
    }
    
    static func mock() -> User {
        mockIDCounter += 1
        
        return User(
            userID: mockIDCounter,
            name: "Test User",
            pfpURL: URL(string: "https://shorturl.at/vYd1A"),
            isVerified: false
        )
    }
}

struct UserDetails: Codable, NamedIdentifiable {
    let userID: UUID
    let name: String
    var pfpURL: URL? = nil
    let isVerified: Bool
    var timeZone: String? = nil
    var auth0ID: String? = nil
    var school: School?  = nil
    
    var id: UUID { userID }
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name = "username"
        case pfpURL = "pfp_url"
        case isVerified = "is_verified"
        case timeZone = "time_zone"
        case auth0ID = "auth0_id"
        case school = "school_id"
    }
    
    static func mock() -> UserDetails {
        return UserDetails(userID: UUID(), name: "Test User", pfpURL: URL(string: "https://shorturl.at/vYd1A"), isVerified: false)
    }
}
