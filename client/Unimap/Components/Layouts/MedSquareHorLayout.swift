import SwiftUI

struct MedSquareHorLayout: View {
    let events: [Event]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(events) { event in
                    MediumSquareCard(
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

