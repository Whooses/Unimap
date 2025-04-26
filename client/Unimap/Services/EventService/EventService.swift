import Foundation

class EventService {
    let apiURLString = "http://127.0.0.1:8000/events/"

    func loadEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: apiURLString) else {
            let error = NSError(
                domain: "InvalidURL",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
            )
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    let err = NSError(
                        domain: "NoData",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "No data received"]
                    )
                    completion(.failure(err))
                    return
                }
                do {
                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completion(.success(events))
                } catch let decodingError as DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("⚠️ Missing key '\(key.stringValue)' – \(context.debugDescription)")
                    case .typeMismatch(let type, let context):
                        print("⚠️ Type mismatch for \(type) – \(context.debugDescription)")
                    default:
                        print("⚠️ Decoding error: \(decodingError.localizedDescription)")
                    }
                    completion(.failure(decodingError))
                } catch {
                    print("⚠️ Unexpected error: \(error.localizedDescription)")
                    completion(.failure(error))
                }

            }
        }.resume()
    }
}
