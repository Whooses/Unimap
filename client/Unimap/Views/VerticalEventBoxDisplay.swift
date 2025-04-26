import SwiftUI

struct EventBoxDisplay: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        VStack(alignment: .center) {
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
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 5) {
                        ForEach(viewModel.events) { event in
                            RectangleComponent(
                              username: event.username ?? "Unknown User",
                              userPFP: "test",
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
            viewModel.loadEvents()
        }
    }
}


