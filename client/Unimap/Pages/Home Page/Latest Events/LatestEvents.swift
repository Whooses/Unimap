//
//  LatestEvents.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct LatestEvents: View {
    @State private var events: [Event] = [] // State to hold fetched events

    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest Events")
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
                            LatestEventCard(
                                username: "Whooses", // Replace with actual username if available
                                userPFP: "stockUser",
                                eventImage: "eventImage1"
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onAppear {
            fetchEvents() // Fetch events when the view appears
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
