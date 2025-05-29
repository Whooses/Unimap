import Foundation

// MARK: General URLRequest builder

/// A utility struct to build `URLRequest` objects with configurable components.
class URLRequestBuilder {
    
    // URLRequest Components
    var method: String = "GET"
    var headers: [String: String] = [:]
    var body: Data? = nil
    var timeout: TimeInterval = 30
    
    // URL Components
    var scheme: String = "http"
    var host: String = "127.0.0.1"
    var port: Int = 8000
    var path: String = "/"
    var queryItems: [URLQueryItem] = []
    
    // MARK: - Body Helpers
    
    /// Sets the HTTP body to the JSON-encoded representation of a given model.
    /// - Parameter model: An encodable model to encode into JSON.
    /// - Throws: An error if encoding fails.
    func setJSONBody<T: Encodable>(model: T) throws {
        let encoder = JSONEncoder()
        
        do {
            self.body = try encoder.encode(model)
            headers["Content-Type"] = "application/json"
        } catch {
            throw error
        }
    }
    
    // MARK: - Request Builder
    
    /// Builds a `URLRequest` using the provided URL and request components.
    /// - Returns: A fully-formed `URLRequest` object, or `nil` if the URL could not be constructed.
    func build() throws -> URLRequest {
        // Building the URL
        var components: URLComponents = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            throw URLRequestBuilderError.invalidURLComponents
        }
        
        // Construct the URLRequest
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}


// MARK: EventService URLRequest builder

extension URLRequestBuilder {
    
    convenience init(forEventsService: Bool = true) {
        self.init()
        if forEventsService {
            self.path = "/events"
        }
    }
    
    // Set search
    func setSearch(_ search: String) -> Self {
        queryItems = queryItems.filter { $0.name != "search" }
        
        if !search.isEmpty {
            let item = URLQueryItem(name: "search", value: search)
            queryItems.append(item)
        }
        
        return self
    }
    
    // Set platform
    func setPlatform(_ platform: ExploreTab = ExploreTab.all) -> Self {
        if let _ = queryItems.first(
            where: {$0.name == "tab" && $0.value == platform.rawValue}
        ) {
            return self
        }
        
        queryItems = queryItems.filter { $0.name != "tab" }
        
        let item = URLQueryItem(name: "tab", value: platform.rawValue)
        
        queryItems.append(item)
        
        return self
    }
    
    // Set sort
    func setSort(_ sort: Sort  = Sort.latest) -> Self {
        if let _ = queryItems.first(
            where: {$0.name == "sort" && $0.value == sort.rawValue}
        ) {
            return self
        }
        
        queryItems = queryItems.filter { $0.name != "sort" }
        
        let item = URLQueryItem(name: "sort", value: sort.rawValue)
        
        queryItems.append(item)
        
        return self
    }
    
    // Set clubs
    func setClubs(_ clubs: [Club] = []) -> Self {
        queryItems = queryItems.filter { $0.name != "clubs" }
        
        if !clubs.isEmpty {
            let item = URLQueryItem(name: "clubs", value: clubs.map(\.self.name).joined(separator: ","))
            queryItems.append(item)
        }
        
        return self
    }
    
    // Set date range
    // TODO: Might need to change date format later
    func setDateRange(_ startDate: Date? = nil, _ endDate: Date? = nil) -> Self {
        queryItems = queryItems.filter { $0.name != "start_date" && $0.name != "end_date" }
        
        if let startDate = startDate {
            let item = URLQueryItem(name: "start_date", value: ISO8601DateFormatter().string(from: startDate))
            queryItems.append(item)
        }
        
        if let endDate = endDate {
            let item = URLQueryItem(name: "end_date", value: ISO8601DateFormatter().string(from: endDate))
            queryItems.append(item)
        }
        
        return self
    }
}
