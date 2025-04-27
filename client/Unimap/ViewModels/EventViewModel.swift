import Foundation
import Combine

class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var apiURL = "http://127.0.0.1:8000/events"


    private let service = EventService()

    func loadEvents() {
        isLoading = true
        errorMessage = nil

        service.loadEvents { [weak self] result in
             DispatchQueue.main.async {
                 self?.isLoading = false
                 switch result {
                 case .success(let fetched):
                     self?.events = fetched
                 case .failure(let error):
                     self?.errorMessage = error.localizedDescription
                 }
             }
         }
    }
}
