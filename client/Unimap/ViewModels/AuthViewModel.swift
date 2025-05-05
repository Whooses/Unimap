import Foundation
import Auth0
import Combine

// ViewModel for handling Auth0 authentication and token management
class AuthViewModel: ObservableObject {
    
    // Published properties for UI binding
    @Published var isAuthenticated = false
    @Published var userProfile: UserInfo? = nil
    @Published var authError: String? = nil

    // Auth0 credentials manager (uses Keychain internally)
    private let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    // Initialization: attempt silent login on launch
    init() {
        renewToken()
    }

    // Interactive login
    func login() {
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://dev-3pwlmiwfun0hmi7r.us.auth0.com/api/v2/")
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    // Persist securely in Keychain
                    _ = self?.credentialsManager.store(credentials: credentials)
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.authError = error.localizedDescription
                    }
                }
            }
    }

    // Logout and clear credentials
    func logout() {
        Auth0
            .webAuth()
            .clearSession { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        _ = self?.credentialsManager.clear()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.authError = error.localizedDescription
                    }
                }
            }
    }
    
    // Silent token renewal
    func renewToken() {
        credentialsManager.credentials { [weak self] result in
            switch result {
            case .success(let credentials):
                // Use credentials.accessToken, etc.
                DispatchQueue.main.async {
                    _ = self?.credentialsManager.store(credentials: credentials)
                }
                // …any other setup…
            case .failure(let error):
                print("Failed to load credentials:", error)

                // Update auth state
                _ = self?.credentialsManager.clear()

                // Optionally, show an error or route to login
                DispatchQueue.main.async {
                    self?.authError = "Session expired. Please log in again."
                }
            }
        }
    }
}
