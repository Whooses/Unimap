//
//  Upcoming.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct Rectangles: View {
    @State private var events: [Event] = [] // State to hold fetched events

    var body: some View {
        VStack(alignment: .leading) {
            if events.isEmpty {
                Text("No events found.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 5) {  // Vertical stack with spacing
                        ForEach(events) { event in
                            RectangleCard(
                                username: "Whooses",
                                userPFP: "stockUser",
                                eventImage: "eventImage1",
                                eventTitle: event.title,
                                eventDescription: event.description,
                                eventDate: event.date
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .onAppear {
            fetchEvents()
        }
    }

    // Keep the existing fetchEvents() implementation
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
