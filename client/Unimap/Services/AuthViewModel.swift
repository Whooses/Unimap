import Foundation
import Auth0
import JWTDecode

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userName: String?

    func login() {
        Auth0
            .webAuth()
            .audience("https://dev-3pwlmiwfun0hmi7r.us.auth0.com/api/v2/")
            .start { result in
                switch result {
                case .success(let credentials):
                    print("Access Token: \(credentials.accessToken)")
                    
                    DispatchQueue.main.async { // Ensure this runs on the main thread
                        self.isAuthenticated = true
//                        self.decodeUserInfo(idToken: credentials.idToken)
                        print("Logged in successfully!")
                    }
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
                    DispatchQueue.main.async {
                        self.isAuthenticated = false
                        self.userName = nil
                        print("Logged out successfully!")
                    }
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }

    private func decodeUserInfo(idToken: String) {
        do {
            let jwt = try decode(jwt: idToken)
//            print("\(jwt)")
            self.userName = jwt.claim(name: "name").string // Extract the "name" claim
        } catch {
            print("Failed to decode ID token: \(error)")
        }
    }
}
