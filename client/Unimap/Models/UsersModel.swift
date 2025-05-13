import Foundation

struct User: Codable {
    let userID: Int
    let username: String
    let pfpURL: URL?

    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case username
        case pfpURL = "pfp_url"
    }
}
