import Foundation
import Auth0
import Combine

// ViewModel for handling Auth0 authentication and token management
class AuthViewModel: ObservableObject {
    
    // Published properties for UI binding
    @Published var isAuthenticated = false
    @Published var userInfo: UserInfo? = nil
    @Published var authError: String? = nil

    private let auth0 = Auth0.authentication()
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
                    print("Access token: \(credentials.accessToken)\n")
                    print("Refresh token: \(credentials.refreshToken ?? "None")")
                    
                    DispatchQueue.main.async {
                        self?.userInfo = self?.credentialsManager.user
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
                    self?.fetchUserInfo()
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
    
    private func fetchUserInfo() {
        credentialsManager.credentials { result in
            switch result {
            case .success(let credentials):
                let accessToken = credentials.accessToken

                self.auth0
                    .userInfo(withAccessToken: accessToken)
                    .start { result in
                        switch result {
                        case .success(let userInfo):
                            DispatchQueue.main.async {
                                self.userInfo = userInfo  // ← Updated user info here
                            }
                        case .failure(let error):
                            print("Failed to fetch user info: \(error)")
                        }
                    }

            case .failure(let error):
                print("Could not retrieve credentials: \(error)")
            }
        }
    }
}
