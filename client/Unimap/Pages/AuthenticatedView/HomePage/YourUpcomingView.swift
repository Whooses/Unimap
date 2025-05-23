import SwiftUI

struct YourUpcomingView: View {
    let events: [Event]
    
    var body: some View {
        VStack {
            HStack {
                Text("Your upcoming")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            RectangleHorLayout(events: events)
        }
        .frame(height: 250, alignment: .topLeading)
    }
}
