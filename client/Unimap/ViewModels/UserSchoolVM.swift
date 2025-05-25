import Foundation
import Combine

class UserSchoolVM: ObservableObject {
    @Published var user: User
    @Published var school: [School]? = nil
    @Published var clubs: [User]? = nil
    
    init(user: User) {
        self.user = user
    }
    
    func loadSchool() async -> Void {
        fatalError(#function + " not implemented")
    }
    
    func loadClubs() async -> Void {
        fatalError(#function + " not implemented")
    }
}
