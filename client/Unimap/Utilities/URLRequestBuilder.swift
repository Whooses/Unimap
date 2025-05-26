import Foundation

/// A utility struct to build `URLRequest` objects with configurable components.
struct URLRequestBuilder {
    
    // MARK: - Request Components
    var method: String = "GET"
    var headers: [String: String] = [:]
    var body: Data? = nil
    var timeout: TimeInterval = 30
    
    // MARK: - URL Components
    var scheme: String = "http"
    var host: String = "127.0.0.1"
    var port: Int = 8080
    var path: String = "/"
    var queryItems: [URLQueryItem] = []
    
    // MARK: - Body Helpers
    
    /// Sets the HTTP body to the JSON-encoded representation of a given model.
    ///
    /// - Parameter model: An encodable model to encode into JSON.
    /// - Throws: An error if encoding fails.
    mutating func setJSONBody<T: Encodable>(model: T) throws {
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
    ///
    /// - Returns: A fully-formed `URLRequest` object, or `nil` if the URL could not be constructed.
    func build() -> URLRequest? {
        // Building the URL
        var components: URLComponents = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        // Validate URL
        guard let url = components.url else {
            return nil
        }
        
        // Construct the URLRequest
        var request = URLRequest(url: url, timeoutInterval: timeout)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}
