import SwiftUI

struct SmallSquareHorLayout: View {

    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack {
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


