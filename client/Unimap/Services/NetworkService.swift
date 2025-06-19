import Foundation
import SwiftUI

/// A service responsible for making network requests and decoding JSON responses.
class NetworkService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }
    
    // MARK: Network operation

    /// Sends a network request and decodes the JSON response into a specified Decodable type.
    /// - Returns: An instance of the decoded type.
    /// - Throws: `NetworkError` if the request fails, response is invalid, or decoding fails.
    func sendRequest<T: Decodable>(from request: URLRequest, type: T.Type) async throws -> T {
        do {
            print(request.url?.absoluteString ?? "Invalid URL")
            
            let (data, response) = try await session.data(for: request)
            try validateHTTPResponse(response)
            try validateStatusCode(response, data)
            try validateData(data)
            return try decodeData(data, to: T.self)
        } catch let urlError as URLError {
            throw NetworkError.underlying(urlError)
        } catch {
            throw NetworkError.underlying(error)
        }
    }

    // MARK: - Helpers

    /// Validates that the response is an HTTPURLResponse.
    /// - Throws: `NetworkError.custom` if the response is not an HTTPURLResponse.
    private func validateHTTPResponse(_ response: URLResponse) throws {
        guard response is HTTPURLResponse else {
            throw NetworkError.custom("Non-HTTP response")
        }
    }

    /// Validates the HTTP status code and attempts to parse an error message if the request failed.
    /// - Parameters:
    /// - Throws: `NetworkError.invalidStatusCode` or `NetworkError.custom` for API-specific error messages.
    private func validateStatusCode(_ response: URLResponse, _ data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        guard (200...299).contains(httpResponse.statusCode) else {
            // Decode the error message for non 200...299 status code
            if let apiError = try? decoder.decode(APIError.self, from: data) {
                throw NetworkError.custom(apiError.message)
            } else {
                throw NetworkError.invalidStatusCode(httpResponse.statusCode)
            }
        }
    }

    /// Checks that the response data is not empty.
    /// - Throws: `NetworkError.noData` if the data is empty.
    private func validateData(_ data: Data) throws {
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
    }

    /// Decodes JSON data into the specified Decodable type.
    /// - Returns: A decoded instance of the expected type.
    /// - Throws: `NetworkError.decodingError` if decoding fails.
    private func decodeData<T: Decodable>(_ data: Data, to type: T.Type) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
