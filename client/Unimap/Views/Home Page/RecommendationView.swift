//
//  LatestEvents.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct RecommendationView: View {

    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Reccomendation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }

            HStack {
                if eventViewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let errorMessage = eventViewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if eventViewModel.events.isEmpty {
                    Text("No events found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(eventViewModel.events) { event in
                                SmallSquareCard(
                                    username: event.user.username,
                                    userPFP: PFPComponent(
                                        imageUrl: event.user.pfpURL,
                                        size: 40
                                    ),
                                    eventImageURL: event.imageURL
                                )
                            }
                        }
                    }
                }
            }
            .padding(.leading, 25)
            .onAppear {
                Task {
                    do {
                        try await eventViewModel.loadEvents()
                    } catch {
                        eventViewModel.errorMessage = "Failed to fetch events: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
}

