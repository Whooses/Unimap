import Foundation

class EventRequestBuilder: ObservableObject {
    enum Path: String {
        case events = "/events"
    }
    
    enum Sort: String {
        case latest = "latest"
        case upcoming = "upcomming"
        case recentlyAdded = "recently added"
        case alphabetical = "alphabetical"
        case hot = "hot"
    }
    
    enum Club: String {
        case amacs = "amacss"
        case vsa = "VSA"
        case dsh3 = "DSH3"
    }
    
    private var components: URLComponents
    private var queryItems: [URLQueryItem] = []
    
    
    // MARK: - Init
    
    init() {
        components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8000
    }
    
    // MARK: - Builder Methods
    
    func setPath(_ path: Path) -> Self {
        if case .events = path {
            components.path = Path.events.rawValue
        }
        return self
    }
    
    func setSearch(_ text: String) -> Self {
        queryItems.removeAll { $0.name == "search" }
        queryItems.append(URLQueryItem(name: "search", value: text))
        return self
    }
    
    func setSort(_ option: Sort) -> Self {
        queryItems.removeAll { $0.name == "sort" }
        queryItems.append(URLQueryItem(name: "sort", value: option.rawValue))
        return self
    }

    func setClubs(_ clubs: [Club]) -> Self {
        queryItems.removeAll { $0.name == "clubs" }
        let value = clubs.map(\.rawValue).joined(separator: ",")
        queryItems.append(URLQueryItem(name: "clubs", value: value))
        return self
    }
    
    func setStartDate(_ date: Date) -> Self {
        let dateFormatter: DateFormatter = {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt
        }()
        
        let value = dateFormatter.string(from: date)
        queryItems.removeAll { $0.name == "startDate" }
        queryItems.append(URLQueryItem(name: "startDate", value: value))
        return self
    }
    
    func setEndDate(_ date: Date) -> Self {
        let dateFormatter: DateFormatter = {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt
        }()
        
        let value = dateFormatter.string(from: date)
        queryItems.removeAll { $0.name == "endDate" }
        queryItems.append(URLQueryItem(name: "endDate", value: value))
        return self
    }
    
    // MARK: - Build
    
    func build() -> URLRequest? {
        var comps = components
        comps.queryItems = queryItems.isEmpty ? nil : queryItems
        guard let url = comps.url else { return nil }
        return URLRequest(url: url)
    }
}
