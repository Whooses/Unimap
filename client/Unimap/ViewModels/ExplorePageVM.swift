import Foundation
import Combine

class ExplorePageVM: ObservableObject {
    // MARK: Published properties
    @Published var errorMessage: String? = nil
    @Published var search: String = ""
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
    private let eventService: EventService
    let schoolService: SchoolService


    // MARK: Init
    init(schoolService: SchoolService, eventService: EventService) {
        self.eventService = eventService
        self.schoolService = schoolService
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

    func updateSearch(_ newSearch: String) async {
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
    
    func updateSort(_ sort: Sort) {
        if var currFilter = filter[currTab] {
            if currFilter.sort != sort {
                currFilter.sort = sort
                filter[currTab] = currFilter
            }
        }
    }
    
    func updateClubs(_ clubs: [User]) {
        if var currFilter = filter[currTab] {
            if currFilter.clubs != clubs {
                currFilter.clubs = clubs
                filter[currTab] = currFilter
            }
        }
    }
    
    func updateDR(_ startDate: Date?, _ endDate: Date?) {
        if var currFilter = filter[currTab] {
            if (currFilter.startDate != startDate || currFilter.endDate != endDate) {
                currFilter.startDate = startDate
                currFilter.endDate = endDate
                filter[currTab] = currFilter
            }
        }
    }

    func resetFilters() async {
        isLoading[currTab] = true
        
        filter[currTab] = ExploreFilter()
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }
}

// Supported types
enum ExploreTab: String, StringIdentifiableEnum {
    case all
    case inPerson = "in_person"
    case online
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .inPerson:
            return "In person"
        case .online:
            return "Online"
        }
    }
}

struct ExploreFilter {
    var sort: Sort = .latest
    var clubs: [User] = []
    var startDate: Date? = nil
    var endDate: Date? = nil
}

enum SortFilter: String, StringIdentifiableEnum {
    case latest
    case upcoming
    case recentlyAdded = "recently_added"
    case past
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .latest:
            return "Latest"
        case .upcoming:
            return "Upcoming"
        case .recentlyAdded:
            return "Recently added"
        case .past:
            return "Past"
        }
    }
}

enum ClubsFilter: String, StringIdentifiableEnum {
    case amacs
    case csec
    case mathematicsClub = "mathematics_club"
    case programmingClub = "programming_club"
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .amacs:
            return "AMACS"
        case .csec:
            return "CSEC"
        case .mathematicsClub:
            return "Mathematics club"
        case .programmingClub:
            return "Programming club"
        }
    }
}
