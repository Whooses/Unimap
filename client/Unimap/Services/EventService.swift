import Foundation

class EventService {
    private let apiURLString = "http://127.0.0.1:8000/events/"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Actual core function

    func loadEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        do {
            let url = try makeURL()
            performRequest(to: url, completion: completion)
        } catch {
            dispatchResult(.failure(error), to: completion)
        }
    }

    // URL Construction

    private func makeURL() throws -> URL {
        guard let url = URL(string: apiURLString) else {
            throw URLError(.badURL)
        }
        return url
    }

    // Network

    private func performRequest(
        to url: URL,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        session.dataTask(with: url) { data, response, error in
            let result = self.handleNetworkResponse(data: data, error: error)
            self.dispatchResult(result, to: completion)
        }
        .resume()
    }

    private func handleNetworkResponse(
        data: Data?,
        error: Error?
    ) -> Result<[Event], Error> {
        if let error = error {
            return .failure(error)
        }
        guard let data = data else {
            let noDataError = NSError(
                domain: "EventService",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "No data received"]
            )
            return .failure(noDataError)
        }
        return parseEvents(from: data)
    }

    // Parsing

    private func parseEvents(from data: Data) -> Result<[Event], Error> {
        do {
            let decoder = JSONDecoder()
            let events = try decoder.decode([Event].self, from: data)
            return .success(events)
        } catch let decodingError as DecodingError {
            // You can add more granular logging here if desired
            return .failure(decodingError)
        } catch {
            return .failure(error)
        }
    }

    // Dispatch

    private func dispatchResult(
        _ result: Result<[Event], Error>,
        to completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
