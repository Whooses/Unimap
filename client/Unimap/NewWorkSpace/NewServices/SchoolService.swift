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
    func getSchoolClubs(schoolID: Int) async throws -> [User] {
        return [
            User(userID: 1,  username: "amacss_admin",   pfpURL: URL(string: "https://example.com/pfp1.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 2,  username: "math_user",      pfpURL: URL(string: "https://example.com/pfp2.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 3,  username: "csec_lead",      pfpURL: URL(string: "https://example.com/pfp3.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 4,  username: "csec_admin",     pfpURL: URL(string: "https://example.com/pfp4.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 5,  username: "prog_enthusiast",pfpURL: URL(string: "https://example.com/pfp5.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 6,  username: "techie_tim",     pfpURL: URL(string: "https://example.com/pfp6.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 7,  username: "math_admin",     pfpURL: URL(string: "https://example.com/pfp7.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 8,  username: "csec_member1",   pfpURL: URL(string: "https://example.com/pfp8.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 9,  username: "prog_master",    pfpURL: URL(string: "https://example.com/pfp9.jpg"),  isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 10, username: "career_math",    pfpURL: URL(string: "https://example.com/pfp10.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 11, username: "women_cs",       pfpURL: URL(string: "https://example.com/pfp11.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 12, username: "prog_user",      pfpURL: URL(string: "https://example.com/pfp12.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 13, username: "math_speaker",   pfpURL: URL(string: "https://example.com/pfp13.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 14, username: "golf_guru",      pfpURL: URL(string: "https://example.com/pfp14.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 15, username: "ds_talker",      pfpURL: URL(string: "https://example.com/pfp15.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 16, username: "math_ta",        pfpURL: URL(string: "https://example.com/pfp16.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 17, username: "web_starter",    pfpURL: URL(string: "https://example.com/pfp17.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 18, username: "fp_dev",         pfpURL: URL(string: "https://example.com/pfp18.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 19, username: "prog_nightowl",  pfpURL: URL(string: "https://example.com/pfp19.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 20, username: "amacss_speaker", pfpURL: URL(string: "https://example.com/pfp20.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 21, username: "csec_alumni",    pfpURL: URL(string: "https://example.com/pfp21.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 22, username: "oss_helper",     pfpURL: URL(string: "https://example.com/pfp22.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 23, username: "math_mentor",    pfpURL: URL(string: "https://example.com/pfp23.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 24, username: "cloud_fan",      pfpURL: URL(string: "https://example.com/pfp24.jpg"), isVerified: false, timeZone: nil, auth0ID: nil),
            User(userID: 25, username: "prog_advanced",  pfpURL: URL(string: "https://example.com/pfp25.jpg"), isVerified: false, timeZone: nil, auth0ID: nil)
        ]
    }
}
