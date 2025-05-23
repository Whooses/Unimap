import Foundation

struct NewEvent: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let date: Date?
    let location: String?
    let imageURL: URL?
    let isPublic: Bool?
    let departments: [String]?
    let categories: [String]?
    let clubs: [String]?
    let types: [String]?
    let user: NewUser
    let inPerson: Bool?
    let online: Bool?

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
        case inPerson
        case online
    }
}
