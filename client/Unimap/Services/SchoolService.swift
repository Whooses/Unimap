import Foundation

class SchoolService {
    private let networkSerivce = NetworkService()
    
    // MARK: Supported operations
    
    // Get school base on region
    func getSchools(
        country: String?,
        state: String?,
        province: String?,
        city: String?
    ) async throws -> [School] {
        return [
            School(
                id: 2,
                name: "University of Toronto Scarborough",
                stateProvince: "Ontario",
                city: "Scarborough",
                country: "Canada",
                latitude: nil,
                longitude: nil,
                createdAt: Date.now)
        ]
    }
    
    // Get school base on a user
    func getUserSchools(userID: Int) async throws -> [School] {
        return [
            School(
                id: 2,
                name: "University of Toronto Scarborough",
                stateProvince: "Ontario",
                city: "Scarborough",
                country: "Canada",
                latitude: nil,
                longitude: nil,
                createdAt: Date.now)
        ]
    }
    
    // Get a specific shool's detail
    func getSchoolDetail(schoolID: Int) async throws -> School {
        return School(
            id: 2,
            name: "University of Toronto Scarborough",
            stateProvince: "Ontario",
            city: "Scarborough",
            country: "Canada",
            latitude: nil,
            longitude: nil,
            createdAt: Date.now)
    }
    
    // Get all school's clubs
    func getSchoolClubs(schoolID: Int) -> [NewUser] {
        return [
            NewUser(userID: 1,  name: "amacss_admin",   pfpURL: URL(string: "https://example.com/pfp1.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 2,  name: "math_user",      pfpURL: URL(string: "https://example.com/pfp2.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 3,  name: "csec_lead",      pfpURL: URL(string: "https://example.com/pfp3.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 4,  name: "csec_admin",     pfpURL: URL(string: "https://example.com/pfp4.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 5,  name: "prog_enthusiast",pfpURL: URL(string: "https://example.com/pfp5.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 6,  name: "techie_tim",     pfpURL: URL(string: "https://example.com/pfp6.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 7,  name: "math_admin",     pfpURL: URL(string: "https://example.com/pfp7.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 8,  name: "csec_member1",   pfpURL: URL(string: "https://example.com/pfp8.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil)),
            NewUser(userID: 9,  name: "prog_master",    pfpURL: URL(string: "https://example.com/pfp9.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil, school: School(id: 1, name: "UTSC", stateProvince: nil, city: nil, country: nil, latitude: nil, longitude: nil, createdAt: nil))
        ]
    }
}
