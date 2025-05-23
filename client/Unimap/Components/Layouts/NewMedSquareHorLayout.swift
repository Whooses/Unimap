import SwiftUI

struct NewMedSquareHorLayout: View {
    let events: [NewEvent]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(events) { event in
                    NewMediumSquareCard(
                        username: event.user.name,
                        userPFP: PFPComponent(
                            imageUrl: event.user.pfpURL,
                            size: 40
                        ),
                        eventImageURL: event.imageURL,
                        eventTitle: event.title,
                        eventDate: event.date
                    )
                }
            }
            .padding(.leading)
        }
    }
}

