import SwiftUI

struct HomePage: View {
    @StateObject private var builder = EventRequestBuilder()
    
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
