import Foundation

struct School: Codable, Equatable {
    let id: Int
    let name: String
    
    static private var mockID: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    static func mock() -> Self {
        mockID += 1
        
        return .init(id: mockID, name: "Mock")
    }
}

struct SchoolDetails: Codable, Equatable {
    let id: Int
    let name: String
    let stateProvince: String?
    let city: String?
    let country: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    
    static private var mockID: Int = 0
    
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
    
    static func mock() -> Self {
        mockID += 1
        
        return .init(id: mockID, name: "University of Toronto Scarborough", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)
    }
}
