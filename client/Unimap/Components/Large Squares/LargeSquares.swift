//
//  Recommendations.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct LargeSquares: View {
    @State private var events: [Event] = []

    var body: some View {
        VStack(alignment: .leading) {
            Text("Title Text")
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
                            LargeSquareCard(
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

struct LargeSquareCard: View {
    var username: String
    var userPFP: String
    var eventImage: String = "empty"
    var eventTitle: String = "Event Title"
    var eventDate: String = "Jan 18, 2025"

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                // User PFP and Username
                HStack {
                    Image(userPFP)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))

                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                }

                Spacer()

                // Triple-dot menu and Save button
                HStack(spacing: 12) {
                    Button(action: {
                        // Action for triple-dot menu
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }

                    Button(action: {
                        // Action for save button
                    }) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 16)

            // Main Content with Shadow
            VStack(spacing: 0) {
                // Event Image with Title Overlay
                ZStack(alignment: .bottomLeading) {
                    Image(eventImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()

                    // Gradient Blur Background for Title
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.8),
                            Color.black.opacity(0.0)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 60)
                    .blur(radius: 4)
                    .overlay(
                        Text(eventTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .bold()
                            .padding(8),
                        alignment: .bottomLeading
                    )
                }
                .frame(width: 200, height: 200)

                // Footer with Date
                HStack {
                    Text(eventDate)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 5)
        }
        .frame(width: 200, height: 260)
        .padding(16)
    }
}

