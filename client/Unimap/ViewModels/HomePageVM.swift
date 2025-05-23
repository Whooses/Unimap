import Foundation
import Combine

class HomePageVM: ObservableObject {
    // MARK: Published properties
    @Published var search: String = ""
    @Published var events: [HomePageSection: [NewEvent]] = [
        .recommendations: [],
        .yourUpcoming: [],
        .latestEvents: []
    ]
    @Published var isLoading: [HomePageSection: Bool] = [
        .recommendations: false,
        .yourUpcoming: false,
        .latestEvents: false
    ]
    @Published var errorMessage: [HomePageSection: String?] = [
        .recommendations: nil,
        .yourUpcoming: nil,
        .latestEvents: nil
    ]

    // MARK: Private properties
    private let eventService: NewEventService
    let schoolService: SchoolService


    // MARK: Init
    init(schoolService: SchoolService, eventService: NewEventService) {
        self.eventService = eventService
        self.schoolService = schoolService
    }

    // MARK: Operations
    func fetchRecEvents() async {
        do {
            events[.recommendations] = try await eventService.fetchRecEvents(user: nil)
        } catch {
            
        }
    }
    
    func fetchUpcomingEvents() async {
        do {
            events[.yourUpcoming] = try await eventService.fetchUpcomingEvents(user: nil)
        } catch {
            
        }
        
    }
    
    func fetchLatestEvents() async {
        do {
            events[.latestEvents] = try await eventService.fetchLatestEvents(user: nil)
        } catch {
            
        }
    }
}


// Supported types
enum HomePageSection: String, StringIdentifiableEnum {
    case recommendations
    case yourUpcoming
    case latestEvents
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .recommendations:
            return "Recommendations"
        case .yourUpcoming:
            return "Your upcoming"
        case .latestEvents:
            return "Latest events"
        }
    }
}
