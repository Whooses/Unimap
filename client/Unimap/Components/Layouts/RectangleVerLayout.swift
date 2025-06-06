import SwiftUI

struct RectangleVerLayout: View {
    let events: [Event]
    var showHeader: Bool = true

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 5) {
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
                        eventDate: event.date,
                        showHeader: showHeader
                    )
                    .padding(.bottom, showHeader ? 8 : 16)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}





