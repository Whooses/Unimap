import Foundation
import Auth0
import Combine

// ViewModel for handling Auth0 authentication and token management
class AuthViewModel: ObservableObject {
    
    // Published properties for UI binding
    @Published var isAuthenticated = false
    @Published var accessToken: String? = nil
    @Published var idToken: String? = nil
    @Published var refreshToken: String? = nil
    @Published var expiresAt: Date? = nil
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
                    self?.handle(credentials: credentials)
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
                        self?.clearSession()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.authError = error.localizedDescription
                    }
                }
            }
    }
    
    // Store credentials and fetch user info
    private func handle(credentials: Credentials) {
        // Store in-memory
        DispatchQueue.main.async {
            self.accessToken = credentials.accessToken
            self.idToken = credentials.idToken
            self.refreshToken = credentials.refreshToken
            self.expiresAt = credentials.expiresIn
            self.isAuthenticated = true
        }
        // Persist securely in Keychain
        _ = credentialsManager.store(credentials: credentials)

        // Fetch user profile
        Auth0
            .authentication()
            .userInfo(withAccessToken: credentials.accessToken)
            .start { [weak self] result in
                switch result {
                case .success(let profile):
                    DispatchQueue.main.async {
                        self?.userProfile = profile
                    }
                case .failure:
                    break
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
                    self?.accessToken = credentials.accessToken
                }
                // …any other setup…
            case .failure(let error):
                print("Failed to load credentials:", error)

                // Update auth state
                self?.clearSession()

                // Optionally, show an error or route to login
                DispatchQueue.main.async {
                    self?.authError = "Session expired. Please log in again."
                }
            }
        }
    }

    private func clearSession() {
        DispatchQueue.main.async {
            // Clear in-memory
            self.accessToken = nil
            self.idToken = nil
            self.refreshToken = nil
            self.expiresAt = nil
            self.userProfile = nil
            self.isAuthenticated = false
        }
        // Remove from Keychain
        _ = credentialsManager.clear()
    }
}
