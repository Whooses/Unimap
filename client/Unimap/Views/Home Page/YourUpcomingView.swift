import SwiftUI

struct YourUpcomingView: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Your Upcoming")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }
            
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.events) { event in
                                RectangleComponent(
                                    username: event.user.username,
                                    userPFP: PFPComponent(
                                        imageUrl: event.user.pfpURL,
                                        size: 45),
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
}
