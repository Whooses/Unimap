import Foundation
import Combine

/// ViewModel for managing and providing event data to the UI.
class EventViewModel: ObservableObject {
    /// A published array of events fetched from the API.
    @Published var events: [Event] = []
    
    /// Indicates whether a network request is currently in progress.
    @Published var isLoading = false
    
    /// Holds any error message resulting from a failed network request.
    @Published var errorMessage: String?
    

    /// Service responsible for fetching events from the API.
    private let eventService = EventService()

    /// Loads events asynchronously from the API, updates the events list,
    /// and handles loading state and errors.
    func loadEvents(from request: URLRequest) async throws -> Void {
        isLoading = true  // safe UI update

        do {
            let fetched = try await eventService.getEvents(from: request)
            events = fetched  // another UI update
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

