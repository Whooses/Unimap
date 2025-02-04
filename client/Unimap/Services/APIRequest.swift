//
//  APIRequest.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-02-04.
//


import Foundation

struct APIRequest {
    static func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/events") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
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
