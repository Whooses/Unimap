import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidStatusCode(Int)
    case decodingError(Error)
    case noData
    case underlying(Error)
    case nonHTTPURLResponse
    case custom(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidStatusCode(let code):
            return "Server responded with status code \(code)."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .noData:
            return "No data received from server."
        case .underlying(let error):
            return error.localizedDescription
        case .nonHTTPURLResponse:
            return "Non HTTP URL response received."
        case .custom(let message):
            return message
        }
    }
}


