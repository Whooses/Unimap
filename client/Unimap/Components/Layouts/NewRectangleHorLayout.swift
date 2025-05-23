import SwiftUI

struct NewRectangleHorLayout: View {
    let events: [NewEvent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(events) { event in
                    NewRectangleComponent(
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




