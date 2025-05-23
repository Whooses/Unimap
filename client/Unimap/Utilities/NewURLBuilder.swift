import Foundation

class NewEventRequestBuilder: ObservableObject {
    @Published private(set) var lastUpdated = UUID()
    
    private var components: URLComponents
    private var queryItems: [URLQueryItem] = []
    
    
    // MARK: - Init
    
    init() {
        components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8000
        components.path = "/events"
    }
    
    // MARK: - Builder Methods
    func setSearch(_ search: String?) -> Self {
        // Always start by removing any existing "search" item
        queryItems.removeAll { $0.name == "search" }
        
        guard let search = search else {
            lastUpdated = UUID()
            return self
        }

        // Only add the parameter when there's something to search for
        if !search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }

        lastUpdated = UUID()          // notify observers
        return self
    }
    
    func setTab(_ tab: ExploreTab?) -> Self {
        queryItems.removeAll { $0.name == "tab" }
        
        guard let tab = tab else {
            lastUpdated = UUID()
            return self
        }
        
        queryItems.append(URLQueryItem(name: "tab", value: tab.rawValue))
        lastUpdated = UUID()
        return self
    }

    
    func setSort(_ option: Sort) -> Self {
        queryItems.removeAll { $0.name == "sort" }
        queryItems.append(URLQueryItem(name: "sort", value: option.rawValue))
        lastUpdated = UUID() // Trigger update
        return self
    }

//    func setClubs(_ clubs: [NewUser]) -> Self {
//        queryItems.removeAll { $0.name == "clubs" }
//
//        // Remove the param entirely when nothing is selected
//        guard !clubs.isEmpty else {
//            lastUpdated = UUID()
//            return self
//        }
//
//        let value = clubs.map(\.rawValue).joined(separator: ",")
//        queryItems.append(URLQueryItem(name: "clubs", value: value))
//        lastUpdated = UUID()
//        return self
//    }
    
    private func formatted(_ date: Date) -> String {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            return fmt.string(from: date)
        }
    
    @discardableResult
    func setDateRange(start: Date?, end: Date?) -> Self {
        // 1) Remove any existing date params
        queryItems.removeAll { $0.name == "start_date" || $0.name == "end_date" }
        
        // 2) Append if non-nil
        if let sd = start {
            queryItems.append(URLQueryItem(name: "start_date", value: formatted(sd)))
        }
        if let ed = end {
            queryItems.append(URLQueryItem(name: "end_date", value: formatted(ed)))
        }
        
        // 3) Trigger a single update
        lastUpdated = UUID()
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
