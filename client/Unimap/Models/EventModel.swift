import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let date: String?
    let location: String?
    let imageURL: URL?
    let isPublic: Bool?
    let departments: [String]?
    let categories: [String]?
    let clubs: [String]?
    let types: [String]?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case date
        case location
        case imageURL = "image_url"
        case isPublic = "is_public"
        case departments
        case categories
        case clubs
        case types
        case user
    }
}
