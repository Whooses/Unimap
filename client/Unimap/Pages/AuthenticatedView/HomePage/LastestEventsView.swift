import SwiftUI

struct LastestEventsView: View {
    let events: [NewEvent]

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
            NewSmallSquareHorLayout(events: events)
        }
        .frame(height: 250, alignment: .topLeading)
    }
}
