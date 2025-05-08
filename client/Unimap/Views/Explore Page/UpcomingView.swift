
import SwiftUI

struct UpcomingView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .firstTextBaseline) {
                Text("Upcoming Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 25)
                Spacer()
            }
            
            FilterBarComponent()
            
            RectangleEventView()

            Spacer()
        }
    }
}
