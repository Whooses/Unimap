import SwiftUI

struct YourUpcomingView: View {
    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Your Upcoming")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }
            
            RectangleHorLayout()
        }
    }
}
