import Foundation
import Combine

// TODO: This VM needs to depend of user id
@MainActor
class HomePageVM: ObservableObject {
    // MARK: Published properties
    @Published var search: String = ""
    @Published var events: [HomePageSection: [Event]] = [
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
    private let eventService: EventService


    // MARK: Init
    init(eventService: EventService) {
        self.eventService = eventService
    }

    // MARK: Operations
    func fetchRecEvents() async {
        do {
            events[.recommendations] = try await eventService.fetchRecEvents(user: nil)
        } catch {
            
        }
    }
    
    func fetchUpcomingEvents() async {
        isLoading[.yourUpcoming] = true
        do {
            events[.yourUpcoming] = try await eventService.fetchUpcomingEvents(user: nil)
        } catch {
            
        }
        isLoading[.yourUpcoming] = false
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
