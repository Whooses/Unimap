import SwiftUI

struct Rectangles: View {
    @State private var events: [Event] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                ProgressView()
                    .padding()
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if events.isEmpty {
                Text("No events found.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 5) {
                        ForEach(events) { event in
                            RectangleCard(
                                username: event.username, // Use event's username
                                userPFP: "stockUser",
                                eventImageURL: URL(string: event.image_url),
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
        .onAppear(perform: loadEvents)
    }

    private func loadEvents() {
        isLoading = true
        APIRequest.fetchEvents { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedEvents):
                    self.events = fetchedEvents
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Failed to load events: \(error.localizedDescription)")
                }
            }
        }
    }
}
