import Foundation

struct UserInfo: Codable {
    let username: String
    let pfpURL: URL?

    enum CodingKeys: String, CodingKey {
        case username
        case pfpURL = "pfp_url"
    }
}
