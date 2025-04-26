import SwiftUI

struct HorizontalEventBoxDisplay: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        HStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.events.isEmpty {
                Text("No events found.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // 1) Specify horizontal axis
                // 2) Use LazyHStack for better performance
                // 3) Give the scrollview a fixed height so it doesn't expand vertically forever
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.events) { event in
                            RectangleComponent(
                                username: event.username ?? "Unknown User",
                                userPFP: "stockuser",
                                eventImageURL: event.imageURL,
                                eventTitle: event.title,
                                eventDescription: event.description,
                                eventDate: event.date
                            )
                        }
                    }
                }
            }
        }
        .padding(.leading, 25)
        .onAppear {
            viewModel.loadEvents()
        }
    }
}
