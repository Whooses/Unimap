import SwiftUI

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
                                
                                LastestEventsView(events: VM.events[.latestEvents] ?? [])
                                
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



//#Preview {
//    HomePage()
//}
