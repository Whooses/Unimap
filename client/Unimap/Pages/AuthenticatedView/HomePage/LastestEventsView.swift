import SwiftUI

struct LastestEventsView: View {
    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Latest Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }
            
            SmallSquareHorLayout()
        }
    }
}
