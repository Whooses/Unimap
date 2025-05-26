import SwiftUI

// Home page is all about showing personalize content base on user
struct HomePage: View {
    @EnvironmentObject private var VM: HomePageVM
    
    @FocusState private var isSearching: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarComponent(searchText: $VM.search)
                    .focused($isSearching)
                    .padding(.bottom)
                
                ZStack {
                    if isSearching {
                        searchingView()
                            .transition(.opacity)
                            .padding(.horizontal, 25)
                    } else {
                        ScrollView() {
                            LazyVStack {
                                RecommendationView(events: VM.events[.recommendations] ?? [])
                                
                                YourUpcomingView(events: VM.events[.yourUpcoming] ?? [])
                                
                                YourFollowingView(events: VM.events[.latestEvents] ?? [])
                                
                                Spacer()
                            }
                            .frame(alignment: .topLeading)
                        }
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






private struct ContentView: View {
    @StateObject private var homePageVM = HomePageVM(
        eventService: EventService()
    )
    
    var body: some View {
        HomePage()
            .environmentObject(homePageVM)
    }
}

//#Preview {
//    ContentView()
//}
