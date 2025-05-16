import Foundation

struct EventRequestBuilder {
    
    enum Path: String {
        case events = "/events"
    }
    
    enum SortOption: String {
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
    
    private static let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt
    }()
    
    // MARK: - Initx
    
    init() {
        components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8000
    }
    
    // MARK: - Builder Methods
    
    @discardableResult
    mutating func setPath(_ path: Path) -> Self {
        if case .events = path {
            components.path = Path.events.rawValue
        }
        return self
    }
    
    @discardableResult
    mutating func setSort(_ option: SortOption) -> Self {
        queryItems.removeAll (where: { $0.name == "sort" })
        queryItems.append(URLQueryItem(name: "sort", value: option.rawValue))
        return self
    }
    
    @discardableResult
    mutating func setClubs(_ clubs: [Club]) -> Self {
        queryItems.removeAll { $0.name == "clubs" }
        let value = clubs.map(\.rawValue).joined(separator: ",")
        queryItems.append(URLQueryItem(name: "clubs", value: value))
        return self
    }
    
    @discardableResult
    mutating func setStartDate(_ date: Date) -> Self {
        let value = Self.dateFormatter.string(from: date)
        queryItems.removeAll { $0.name == "startDate" }
        queryItems.append(URLQueryItem(name: "startDate", value: value))
        return self
    }
    
    @discardableResult
    mutating func setEndDate(_ date: Date) -> Self {
        let value = Self.dateFormatter.string(from: date)
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
