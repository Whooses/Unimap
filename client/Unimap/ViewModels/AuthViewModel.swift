import Foundation
import Auth0
import Combine

/// ViewModel for handling Auth0 authentication, session management, and user info.
/// This class uses Combine to publish authentication state and error updates to the UI.
class AuthViewModel: ObservableObject {

    // MARK: - Published Properties

    /// Indicates whether the user is currently authenticated.
    @Published var isAuthenticated = false

    /// Stores the authenticated user's information retrieved from Auth0.
    @Published var userInfo: UserInfo? = nil

    /// Holds any authentication error messages to display in the UI.
    @Published var authError: String? = nil

    // MARK: - Private Properties

    /// Auth0 authentication client for handling login and user info requests.
    private let auth0 = Auth0.authentication()

    /// Manages storing and retrieving Auth0 credentials securely.
    private let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

    // MARK: - Initialization

    /// Initializes the AuthViewModel and attempts to renew tokens silently on launch.
    init() {
        renewToken()
    }

    // MARK: - Public Methods

    /// Starts an interactive login process using Auth0 WebAuth.
    /// On success, it stores credentials securely and updates authentication state.
    func login() {
        Auth0
            .webAuth()
            .scope("openid profile offline_access")
            .audience("https://dev-3pwlmiwfun0hmi7r.us.auth0.com/api/v2/")
            .start { [weak self] result in
                switch result {
                case .success(let credentials):
                    // Persist credentials securely in Keychain
                    _ = self?.credentialsManager.store(credentials: credentials)
                    print("Access token: \(credentials.accessToken)\n")
                    print("Refresh token: \(credentials.refreshToken ?? "None")")

                    DispatchQueue.main.async {
                        self?.userInfo = self?.credentialsManager.user
                        self?.isAuthenticated = true
                        self?.authError = nil
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.authError = error.localizedDescription
                    }
                }
            }
    }

    /// Attempts to silently renew tokens using stored credentials.
    /// If successful, updates the user info; otherwise, clears the session and shows an error.
    func renewToken() {
        credentialsManager.credentials { [weak self] result in
            switch result {
            case .success(let credentials):
                DispatchQueue.main.async {
                    _ = self?.credentialsManager.store(credentials: credentials)
                    self?.fetchUserInfo()
                }
            case .failure(let error):
                print("Failed to load credentials:", error)
                _ = self?.credentialsManager.clear()
                DispatchQueue.main.async {
                    self?.authError = "Session expired. Please log in again."
                }
            }
        }
    }

    /// Logs out the user by clearing the Auth0 session and stored credentials.
    /// Updates authentication state and clears user info.
    func logout() {
        Auth0
            .webAuth()
            .clearSession { [weak self] result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        _ = self?.credentialsManager.clear()
                        self?.isAuthenticated = false
                        self?.userInfo = nil
                        self?.authError = nil
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.authError = error.localizedDescription
                    }
                }
            }
    }

    // MARK: - Private Methods

    /// Fetches the authenticated user's profile information using the access token.
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
                                self.userInfo = userInfo
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
