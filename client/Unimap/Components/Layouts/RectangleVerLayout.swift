import SwiftUI
import Combine

struct RectangleVerLayout: View {
    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack(alignment: .center) {
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
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 5) {
                        ForEach(eventViewModel.events) { event in
                            RectangleComponent(
                              username: event.user.username,
                              userPFP: PFPComponent(
                                imageUrl: event.user.pfpURL,
                                size: 40
                              ),
                              eventImageURL: event.imageURL,
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


