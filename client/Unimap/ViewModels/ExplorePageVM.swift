import Foundation
import Combine

@MainActor
class ExplorePageVM: ObservableObject {
    // MARK: Published properties
    @Published var errorMessage: String? = nil
    @Published var search: String = ""
    @Published var currTab: ExploreTab = .all
    @Published var events: [ExploreTab: [Event]] = [
        .all: [],
        .inPerson: [],
        .online: []
    ]
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
            errorMessage = "Unexpected state: filter not found for tab \(currTab)"
            
            isLoading[currTab] = false
            
            return
        }
        
        do {
            let data = try await eventService.fetchExploreEvents(
                search: search,
                tab: currTab,
                filter: selectedFilter
            )
            events[currTab] = data
            
            isLoading[currTab] = false
        } catch {
            errorMessage = error.localizedDescription
            
            isLoading[currTab] = false
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
    
    func updateSort(_ sort: Sort) async {
        isLoading[currTab] = true
        
        if var currFilter = filter[currTab] {
            if currFilter.sort != sort {
                currFilter.sort = sort
                filter[currTab] = currFilter
            }
        }
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }
    
    func updateClubs(_ clubs: [Club]) async {
        isLoading[currTab] = true
        
        if var currFilter = filter[currTab] {
            if currFilter.clubs != clubs {
                currFilter.clubs = clubs
                filter[currTab] = currFilter
            }
        }
        
        await fetchEvents()
        
        isLoading[currTab] = false
    }
    
    func updateDR(_ startDate: Date?, _ endDate: Date?) async {
        isLoading[currTab] = true
        
        if var currFilter = filter[currTab] {
            if (currFilter.startDate != startDate || currFilter.endDate != endDate) {
                currFilter.startDate = startDate
                currFilter.endDate = endDate
                filter[currTab] = currFilter
            }
        }
        
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
