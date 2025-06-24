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
    
    private var skip: Int = 0
    private var limit: Int = 15
    
    init(
        eventService: EventService,
        userService: UserService
    ) {
        self.eventService = eventService
        self.userService = userService
        print("view loaded")
    }
    
    // MARK: Operations
    func followUser() async {
        
    }
    
    // Message action
    func messageUser() async {
        
    }
    
    func fetchEvents() async {
        isLoading = true
        
        Task.detached {
            do {
                let data = try await self.eventService.fetchUserEvents(
                    skip: 0,
                    limit: 20,
                    userID: self.userID,
                    sort: self.selectedSort
                )
                await MainActor.run {
                    self.skip += 20
                    self.events = data
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchMoreEvents() async {
        isLoading = true
        
        Task.detached {
            do {
                let data = try await self.eventService.fetchUserEvents(
                    skip: self.skip,
                    limit: self.limit,
                    userID: self.userID,
                    sort: self.selectedSort
                )
                await MainActor.run {
                    self.skip += self.limit
                    self.events.append(contentsOf: data)
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
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
