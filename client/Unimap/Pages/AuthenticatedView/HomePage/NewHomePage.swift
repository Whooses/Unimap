import SwiftUI

struct NewHomePage: View {
    @StateObject private var VM: HomePageVM = HomePageVM(
        schoolService: SchoolService(),
        eventService: NewEventService()
    )
    
    @FocusState private var isSearching: Bool
    
    var body: some View {
        VStack {
            NewSearchBarComponent(searchText: $VM.search)
                .focused($isSearching)
                .padding(.bottom)
            
            ZStack {
                if isSearching {
                    searchingView()
                        .transition(.opacity)
                        .padding(.horizontal, 25)
                } else {
                    ScrollView() {
                        VStack {
                            RecommendationView(events: VM.events[.recommendations] ?? [])
                            
                            YourUpcomingView(events: VM.events[.yourUpcoming] ?? [])
                            
                            LastestEventsView(events: VM.events[.latestEvents] ?? [])
                            
                            Spacer()
                        }
                        .frame(alignment: .topLeading)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await VM.fetchRecEvents()
                await VM.fetchUpcomingEvents()
                await VM.fetchLatestEvents()
            }
        }
    }
}
