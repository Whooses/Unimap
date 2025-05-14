import SwiftUI

struct HomePage: View {
    var body: some View {
        ScrollView() {
            VStack {
                SearchBarComponent()
                
                RecommendationView()
                
                YourUpcomingView()
//                
                LastestEventsView()
                
                Spacer()
            }
        }
    }
}
