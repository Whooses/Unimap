import SwiftUI

struct OnlineEventsView: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
 
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text("Oneline events")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 8)
                    .padding(.leading)
                Spacer()
            }
            
            NewExploreFilterLayout()
            NewRectangleVerLayout(events: explorePageVM.events)
//            Spacer()
        }
    }
}

#Preview {
    AllEventSView()
}

