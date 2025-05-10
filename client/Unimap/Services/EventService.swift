import Foundation
import SwiftUI


class EventService {

    private let networkService = NetworkService()

    func getEvents(from request: URLRequest) async throws -> [Event]{
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
