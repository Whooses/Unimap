import Foundation

struct APIRequest {
    let url: URL

    // Initialize with a URL string
    init(urlString: String) throws {
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        self.url = url
    }

    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "NoData", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([Event].self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
