import Foundation
import SwiftUI


/// A service responsible for making network requests and decoding JSON responses.
struct NetworkService {
    /// The URLSession instance used to perform network requests.
    private let session: URLSession

    /// Initializes the NetworkService with a URLSession.
    /// - Parameter session: The URLSession to use. Defaults to `URLSession.shared`.
    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Sends an asynchronous HTTP request and decodes the response into an array of the specified type.
    ///
    /// - Parameters:
    ///   - request: The `URLRequest` to be sent.
    ///   - type: The `Decodable` type to decode the response into.
    /// - Returns: An array of decoded objects of type `T`.
    /// - Throws: An error if the network request fails, if the HTTP response status code is not in the 200–299 range,
    ///           or if decoding the response data fails.
    ///
    /// - Note: This function is generic and works with any type conforming to `Decodable`.
    func sendRequest<T: Decodable>(from request: URLRequest, type: T.Type) async throws -> T {
        // Performing network call
        let (data, response) = try await session.data(for: request)

        // Handle http respond errors
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw NSError(
                domain: "",
                code: httpResponse.statusCode,
                userInfo: [NSLocalizedDescriptionKey:
                            "Server error: \(httpResponse.statusCode)"]
            )
        }

        // Handle decoding error
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
