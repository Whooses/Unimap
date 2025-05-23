import SwiftUI

struct RectangleVerLayout: View {
    let events: [Event]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 5) {
                ForEach(events) { event in
                    RectangleComponent(
                        username: event.user.name,
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




