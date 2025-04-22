import Foundation

class EventService {
    func loadEvents(from urlString: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        do {
            let apiRequest = try APIRequest(urlString: urlString)
            apiRequest.fetchEvents { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
