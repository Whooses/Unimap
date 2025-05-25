import SwiftUI

struct SmallSquareHorLayout: View {
    let events: [Event]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(events) { event in
                    SmallSquareCard(
                        username: event.user.name,
                        userPFP: PFPComponent(
                            imageUrl: event.user.pfpURL,
                            size: 40
                        ),
                        eventImageURL: event.imageURL
                    )
                }
            }
            .padding(.leading)
        }
    }
}


