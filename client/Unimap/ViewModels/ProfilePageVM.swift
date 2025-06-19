import Foundation

@MainActor
class ProfilePageVM: ObservableObject {
    @Published var eventsCounts: Int = 0
    @Published var followerCounts: Int = 0
    @Published var attendedCounts: Int = 0
    @Published var search: String = ""
    @Published var selectedSort: Sort = .latest
    @Published var events: [Event] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    @Published var userID: Int = 0
    
    private let eventService: EventService
    private let userService: UserService
    
    init(
        eventService: EventService,
        userService: UserService
    ) {
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
            let data = try await eventService.fetchUserEvents(
                userID: userID,
                sort: selectedSort
            )
            
            events = data
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            
            isLoading = false
        }
    }
    
    // Update sort
    func updateSort(_ sort: Sort) async {
        isLoading = true
        
        if sort != selectedSort {
            selectedSort = sort
        }
        
        
        await fetchEvents()
        
        isLoading = false
    }
    
    // Search events
    func searchEvents() async {
        
    }

}
