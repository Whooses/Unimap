import Foundation

class EventDetailsVM: ObservableObject {
    @Published var eventDetails: EventDetails? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let eventSerive: EventService
    
    init(eventSerive: EventService) {
        self.eventSerive = eventSerive
    }
    
    func loadEventDetails(id: UUID) async -> Void {
        
    }
    
}
