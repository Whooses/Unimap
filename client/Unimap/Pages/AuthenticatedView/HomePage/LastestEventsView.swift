import SwiftUI

struct LastestEventsView: View {
    let events: [Event]

    var body: some View {
        VStack {
            HStack {
                Text("Latest events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            SmallSquareHorLayout(events: events)
        }
        .frame(height: 250, alignment: .topLeading)
    }
}
