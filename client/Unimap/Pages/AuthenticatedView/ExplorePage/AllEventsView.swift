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
            
            ExploreFilterLayout()
            
            if explorePageVM.errorMessage == "No data received from server." {
                Text("No events")
                    .foregroundColor(.secondary)
                    .offset(y: 10)
            } else if let error = explorePageVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .offset(y: 10)
            } else {
                RectangleVerLayout(events: explorePageVM.events[.all])
            }
            
            Spacer()
        }
    }
}

//#Preview {
//    AllEventSView()
//}

