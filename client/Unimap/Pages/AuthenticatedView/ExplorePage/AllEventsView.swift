import SwiftUI

struct AllEventSView: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
 
    var body: some View {
        VStack {
            HStack {
                Text("All events")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 8)
                    .padding(.leading)
                Spacer()
            }
            
            NewExploreFilterLayout()
            NewRectangleVerLayout(events: explorePageVM.events)
        }
    }
}

//#Preview {
//    AllEventSView()
//}

