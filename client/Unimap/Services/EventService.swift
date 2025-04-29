import Foundation

class EventService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Now you pass in the full endpoint you want to hit.
    func loadEvents(
        apiURLString: String,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        guard let url = URL(string: apiURLString) else {
            dispatchResult(result: .failure(URLError(.badURL)), completion: completion)
            return
        }
        performRequest(to: url, completion: completion)
    }

    // MARK: — Network

    private func performRequest(
        to url: URL,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        session.dataTask(with: url) { data, response, error in
            let result = self.handleNetworkResponse(data: data, error: error)
            self.dispatchResult(result: result, completion: completion)
        }
        .resume()
    }

    private func handleNetworkResponse(
        data: Data?,
        error: Error?
    ) -> Result<[Event], Error> {
        if let error = error { return .failure(error) }
        guard let data = data else {
            let noDataError = NSError(
                domain: "EventService",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "No data received"]
            )
            return .failure(noDataError)
        }
        return parseEvents(data: data)
    }

    // MARK: — Parsing

    private func parseEvents(data: Data) -> Result<[Event], Error> {
        do {
            let events = try JSONDecoder().decode([Event].self, from: data)
            return .success(events)
        } catch {
            return .failure(error)
        }
    }

    // MARK: — Dispatch

    private func dispatchResult(
        result: Result<[Event], Error>,
        completion: @escaping (Result<[Event], Error>) -> Void
    ) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
