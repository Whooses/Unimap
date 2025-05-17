import Foundation

class EventRequestBuilder: ObservableObject {
    enum Path: String {
        case events = "/events"
    }
    
    enum Sort: String {
        case latest = "latest"
        case upcoming = "upcoming"
        case recentlyAdded = "recently added"
        case past = "past"
        case alphabetical = "alphabetical"
        case hot = "hot"
    }
    
    enum Club: String {
        case amacss = "amacss"
        case vsa = "vsa"
        case create = "create"
        
        /// Case-insensitive initializer
        init?(caseInsensitive value: String) {
            self.init(rawValue: value.lowercased())
        }
    }
    @Published private(set) var lastUpdated = UUID()
    
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
            lastUpdated = UUID() // Trigger update
        }
        return self
    }
    
    func setSearch(_ text: String) -> Self {
        // Always start by removing any existing "search" item
        queryItems.removeAll { $0.name == "search" }

        // Only add the parameter when there's something to search for
        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: text))
        }

        lastUpdated = UUID()          // notify observers
        return self
    }

    
    func setSort(_ option: Sort) -> Self {
        queryItems.removeAll { $0.name == "sort" }
        queryItems.append(URLQueryItem(name: "sort", value: option.rawValue))
        lastUpdated = UUID() // Trigger update
        return self
    }

    func setClubs(_ clubs: [Club]) -> Self {
        queryItems.removeAll { $0.name == "clubs" }

        // Remove the param entirely when nothing is selected
        guard !clubs.isEmpty else {
            lastUpdated = UUID()
            return self
        }

        let value = clubs.map(\.rawValue).joined(separator: ",")
        queryItems.append(URLQueryItem(name: "clubs", value: value))
        lastUpdated = UUID()
        return self
    }
    
    func setStartDate(_ date: Date) -> Self {
        let dateFormatter: DateFormatter = {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            lastUpdated = UUID() // Trigger update
            return fmt
        }()
        
        let value = dateFormatter.string(from: date)
        queryItems.removeAll { $0.name == "startDate" }
        queryItems.append(URLQueryItem(name: "startDate", value: value))
        lastUpdated = UUID() // Trigger update
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
        lastUpdated = UUID() // Trigger update
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
