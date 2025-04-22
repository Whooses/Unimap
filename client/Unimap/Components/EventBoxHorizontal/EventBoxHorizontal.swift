import SwiftUI

struct EventBoxHorizontal: View {
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
        let apiURL = "http://127.0.0.1:8000/events?" // Define your API URL here
        EventService().loadEvents(from: apiURL) { result in
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

struct RectangleCard: View {
    let username: String
    let userPFP: String
    let eventImageURL: URL?
    let eventTitle: String
    let eventDescription: String
    let eventDate: String
    
    @StateObject private var imageLoader = ImageLoader(url: nil)
    @State private var cardColor = Color(.systemGray)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header (unchanged)
            HStack {
                Image(userPFP)
                    .resizable()
                    .frame(width: 35, height: 30)
                    .clipShape(Circle())
                Text(username)
                    .font(.headline)
                    .bold()
            }
            
            // Event Content
            HStack(spacing: 0) {
                // Image Section
                Group {
                    if let image = imageLoader.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 140, height: 140)
                .clipShape(.rect(
                    topLeadingRadius: 14,
                    bottomLeadingRadius: 14,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 0
                ))
                .clipped()
                
                // Text Section
                VStack(alignment: .leading) {
                    Text(eventTitle)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.bottom, 10)
                    
                    Text(eventDescription)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .padding(.bottom, 10)
                    
                    Text(eventDate)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(cardColor)
                )
            }
            .frame(width: 350, height: 140)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(cardColor)
                    .shadow(radius: 10)
            )
        }
        .frame(width: 320)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .onAppear {
            imageLoader.url = eventImageURL
            Task {
                await imageLoader.load()
                if let newColor = imageLoader.averageColor {
                    cardColor = newColor
                }
            }
        }
    }
}

