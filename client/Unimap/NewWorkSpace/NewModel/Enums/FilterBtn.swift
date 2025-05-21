import Foundation

enum Sort: String, StringIdentifiableEnum {
    case latest = "Latest"
    case upcomming = "Upcomming"
    case recentlyAdded = "Recently Added"
    case pastEvents = "Past Events"
    
    var id: String { rawValue }
}
