import Foundation
import Combine

class ExplorePageVM: ObservableObject {
    // MARK: Published properties
    @Published var errorMessage: String? = nil
    @Published var search: String? = nil
    @Published var currTab: ExploreTab = .all
    @Published var events: [Event] = []
    @Published var filteredEvents: [Event] = []
    @Published var filter: [ExploreTab: ExploreFilter] = [
        .all: ExploreFilter(),
        .inPerson: ExploreFilter(),
        .online: ExploreFilter()
    ]
    @Published var isLoading: [ExploreTab: Bool] = [
        .all: false,
        .inPerson: false,
        .online: false
    ]

    // MARK: Private properties
    private let eventService: TestEventService


    // MARK: Init
    init(eventService: TestEventService) {
        self.eventService = eventService
    }

    // MARK: Operations
    func fetchEvents() async {
        isLoading[currTab] = true
        
        guard let selectedFilter = filter[currTab] else {
            isLoading[currTab] = false
            errorMessage = "Unexpected state: filter not found for tab \(currTab)"
            return
        }
        
        do {
            let data = try await eventService.fetchExploreEvents(
                search: search,
                tab: currTab,
                filter: selectedFilter
            )
            events = data
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func updateSearch(_ newSearch: String?) async {
        isLoading[currTab] = true
        
        search = newSearch
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }

    func updateTab(_ tab: ExploreTab) async {
        isLoading[currTab] = true
        
        currTab = tab
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }

    func updateFilters(_ newFilter: ExploreFilter) async {
        isLoading[currTab] = true
        
        filter[currTab] = newFilter
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }

    func resetFilters() async {
        isLoading[currTab] = true
        
        filter[currTab] = ExploreFilter()
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }
}

// Supported types
enum ExploreTab: String {
    case all = "All"
    case inPerson = "In person"
    case online = "Online"
}

struct ExploreFilter {
    var sort: SortFilter = .latest
    var clubs: [ClubsFilter] = []
    var startDate: Date? = nil
    var endDate: Date? = nil
}

enum SortFilter: String {
    case latest = "Latest"
    case upcoming = "Upcoming"
    case recentlyAdded = "Recently added"
    case past = "Past"
}

enum ClubsFilter: String {
    case amacs = "AMACS"
    case csec = "CSEC"
    case mathematicsClub = "Mathematics Club"
    case programmingClub = "Programming Club"
}
