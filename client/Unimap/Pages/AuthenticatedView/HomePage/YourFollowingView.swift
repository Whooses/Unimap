import SwiftUI

struct YourFollowingView: View {
    let events: [Event]

    var body: some View {
        VStack {
            HStack {
                Text("Your following")
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
