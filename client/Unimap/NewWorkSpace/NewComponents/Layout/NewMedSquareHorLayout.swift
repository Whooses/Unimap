import SwiftUI

struct NewMedSquareHorLayout: View {
    let events: [Event]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(events) { event in
                    MediumSquareCard(
                        username: event.user.username,
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
        }
    }
}

