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
        fatalError(#function + " not implemented")
    }
    
    // Get school base on a user
    func getUserSchools(userID: Int) async throws -> [School] {
        fatalError(#function + " not implemented")
    }
    
    // Get a specific shool's detail
    func getSchoolDetail(schoolID: Int) async throws -> School {
        fatalError(#function + " not implemented")
    }
    
    // Get all school's clubs
    func getSchoolClubs(schoolID: Int) async throws -> [User] {
        fatalError(#function + " not implemented")
    }
}
