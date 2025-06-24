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
    ) async throws -> [SchoolDetails] {
        return [
            SchoolDetails.mock()
        ]
    }
    
    // Get school base on a user
    func getUserSchools(userID: Int) async throws -> [SchoolDetails] {
        return [
            SchoolDetails.mock()
        ]
    }
    
    // Get a specific shool's detail
    func getSchoolDetail(schoolID: Int) async throws -> SchoolDetails {
        return SchoolDetails.mock()
    }
    
    // Get all school's clubs
    func getSchoolClubs(schoolID: Int) -> [Club] {
        return [
            Club(clubID: 1, name: "AMACSS", pfpURL: URL(string: "https://www.amacss.org/favicon.svg"), school: nil),
            Club(clubID: 2, name: "C.R.E.A.T.E", pfpURL: URL(string: "https://www.amacss.org/favicon.svg"), school: nil),
            Club(clubID: 3, name: "GDG", pfpURL: URL(string: "https://www.amacss.org/favicon.svg"), school: nil),
            Club(clubID: 4, name: "UTMIST", pfpURL: URL(string: "https://www.amacss.org/favicon.svg"), school: nil)
        ]
    }
}
