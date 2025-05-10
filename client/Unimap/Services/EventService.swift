import Foundation
import SwiftUI

/// Service responsible for fetching event data from the network.
class EventService {

    /// Handles network requests and responses.
    private let networkService = NetworkService()

    /// Fetches an array of `Event` objects from the provided URL request.
    ///
    /// - Parameter request: The URLRequest specifying the endpoint for events.
    /// - Returns: An array of `Event` objects.
    /// - Throws: An error if the network request fails or decoding is unsuccessful.
    func getEvents(from request: URLRequest) async throws -> [Event] {
        do {
            let data: [Event] = try await self.networkService.sendRequest(from: request, type: Event.self)
            return data
        } catch {
            throw error
        }
    }

    // Caching, storage

    // Error Handling
}
