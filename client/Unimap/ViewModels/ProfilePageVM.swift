import Foundation

class ProfilePageVM: ObservableObject {
    @Published var eventsCounts: Int = 0
    @Published var followerCounts: Int = 0
    @Published var attendedCounts: Int = 0
    @Published var search: String = ""
    @Published var selectedSort: Sort = .latest
    @Published var events: [Event] = []
    @Published var errorMessage: String? = nil
    
    let userID: UUID
    
    private let eventService: EventService
    private let userService: UserService
    
    private var isLoading = false
    
    init(
        userID: UUID,
        eventService: EventService,
        userService: UserService
    ) {
        self.userID = userID
        self.eventService = eventService
        self.userService = userService
    }
    
    // MARK: Operations
    func followUser() async {
        
    }
    
    // Message action
    func messageUser() async {
        
    }
    
    func fetchEvents() async {
        isLoading = true
        
        do {
            let data = try await eventService.fetchUserEvents()
            
            events = data
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // Update sort
    func updateSort(_ sort: Sort) {
        
    }
    
    // Search events
    func searchEvents() async {
        
    }

}
