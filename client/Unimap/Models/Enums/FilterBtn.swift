import Foundation

enum Sort: String, StringIdentifiableEnum {
    case latest
    case upcoming
    case recentlyAdded = "recently_added"
    case pastEvents
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .latest:
            return "Latest"
        case .upcoming:
            return "Upcoming"
        case .recentlyAdded:
            return "Recently added"
        case .pastEvents:
            return "Past"
        }
    }
}
