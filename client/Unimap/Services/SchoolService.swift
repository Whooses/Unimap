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
    func getSchoolClubs(schoolID: Int) -> [User] {
        return [
            User.mock(), User.mock(), User.mock(),
            User.mock(), User.mock(), User.mock()
        ]
    }
}
