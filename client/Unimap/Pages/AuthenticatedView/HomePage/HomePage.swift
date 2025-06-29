import SwiftUI

// Home page is all about showing personalize content base on user
struct HomePage: View {
    @EnvironmentObject private var VM: HomePageVM
    
    @FocusState private var isSearching: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarComponent() { newSearch in
                    
                }
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

private struct RecommendationView: View {
    let events: [Event]
    
    var body: some View {
        VStack {
            HStack {
                Text("Reccomendations")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            MedSquareHorLayout(events: events)
        }
        .frame(alignment: .topLeading)
    }
}

private struct YourFollowingView: View {
    let events: [Event]

    var body: some View {
        VStack {
            HStack {
                Text("Your following")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            SmallSquareHorLayout(events: events)
        }
        .frame(height: 250, alignment: .topLeading)
    }
}


private struct YourUpcomingView: View {
    let events: [Event]
    
    var body: some View {
        VStack {
            HStack {
                Text("Your upcoming")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            RectangleHorLayout(events: events)
        }
        .frame(height: 250, alignment: .topLeading)
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
