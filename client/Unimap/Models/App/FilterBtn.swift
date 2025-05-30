import Foundation

struct ExploreFilter {
    var sort: Sort = .latest
    var clubs: [Club] = []
    var startDate: Date? = nil
    var endDate: Date? = nil
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

enum Sort: String, StringIdentifiableEnum {
    case latest
    case upcoming
    case recentlyAdded = "recently_added"
    case past
    
    var id: String { rawValue }
    
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

