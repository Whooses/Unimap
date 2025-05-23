import SwiftUI

struct NewSmallSquareHorLayout: View {
    let events: [NewEvent]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
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
        }
    }
}


