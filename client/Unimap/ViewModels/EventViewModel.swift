import Foundation
import Combine

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/events")!)

    private let eventService = EventService()

    func loadEvents() async throws -> Void {
        isLoading = true             // safe UI update

        do {
            let fetched = try await eventService.getEvents(from: request)
            events = fetched         // another UI update
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
