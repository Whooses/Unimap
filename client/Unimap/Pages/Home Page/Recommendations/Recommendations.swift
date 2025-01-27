//
//  Recommendations.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct Recommendations: View {
    @State private var events: [Event] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommendations")
                .font(.title2)
                .bold()
                .padding(.leading, 16)
                .padding(.bottom, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if events.isEmpty {
                        Text("No events found.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(events) { event in
                            RecommendCard(
                                username: event.username,
                                userPFP: "stockUser",
                                eventImage: "eventImage1",
                                eventTitle: event.title,
                                eventDate: event.date
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onAppear {
            fetchEvents()
        }
    }

    private func fetchEvents() {
        guard let url = URL(string: "http://127.0.0.1:8000/events") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Fetch failed: \(error.localizedDescription)")
                return
            }

            if let data = data {
                let jsonString = String(data: data, encoding: .utf8)
                print("API Response: \(jsonString ?? "No data")")

                do {
                    let decodedResponse = try JSONDecoder().decode([Event].self, from: data)
                    DispatchQueue.main.async {
                        self.events = decodedResponse
                    }
                } catch {
                    print("Decoding failed: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
