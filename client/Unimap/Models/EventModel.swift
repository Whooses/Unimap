import Foundation

struct Event: Codable, Identifiable {
    let id: Int
    let title: String
    var description: String? = nil
    var date: Date? = nil
    var location: String? = nil
    var imageURL: URL? = nil
    var isPublic: Bool? = nil
    var departments: [String]? = nil
    var categories: [String]? = nil
    var clubs: [String]? = nil
    var types: [String]? = nil
    let user: User
    var inPerson: Bool? = nil
    var online: Bool? = nil

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
