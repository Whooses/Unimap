import SwiftUI

struct HomeView: View {
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
