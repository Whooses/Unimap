import Foundation
import SwiftUI


class EventService {

    private let networkService = NetworkService()

    func getEvents(from url: URL) async throws-> [Event] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
