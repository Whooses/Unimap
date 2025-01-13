import Foundation
import Auth0
import JWTDecode

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = true
    @Published var userName: String?

    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    self.isAuthenticated = true
                    self.decodeUserInfo(from: credentials.idToken) // Decode the idToken
                    print("Logged in successfully!")
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    self.isAuthenticated = false
                    self.userName = nil
                    print("Logged out successfully!")
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    private func decodeUserInfo(from idToken: String) {
        do {
            let jwt = try decode(jwt: idToken)
            self.userName = jwt.claim(name: "name").string // Extract the "name" claim
        } catch {
            print("Failed to decode ID token: \(error)")
        }
    }
}
