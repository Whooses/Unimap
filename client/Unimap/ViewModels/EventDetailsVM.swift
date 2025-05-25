import Foundation

@MainActor
class EventDetailsVM: ObservableObject {
    @Published var EventDetails: EventDetails? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let eventSerive: EventService
    
    init(eventSerive: EventService) {
        self.eventSerive = eventSerive
    }
    
    func loadEventDetails(id: UUID) async -> Void {
        
    }
    
}
