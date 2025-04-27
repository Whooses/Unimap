import Foundation

struct UserInfo: Codable {
    let username: String
    let pfpURL: URL?

    enum CodingKeys: String, CodingKey {
        case username
        case pfpURL = "pfp_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        
        // Handle invalid or empty URL strings
        if let urlString = try? container.decode(String.self, forKey: .pfpURL), !urlString.isEmpty {
            pfpURL = URL(string: urlString)
        } else {
            pfpURL = nil
        }
    }
}
