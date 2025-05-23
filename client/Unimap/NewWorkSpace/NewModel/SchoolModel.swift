import Foundation

struct School: Codable, Equatable {
    let id: Int
    let name: String
    let stateProvince: String?
    let city: String?
    let country: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stateProvince = "state_province"
        case city
        case country
        case latitude
        case longitude
        case createdAt = "created_at"
    }
}
