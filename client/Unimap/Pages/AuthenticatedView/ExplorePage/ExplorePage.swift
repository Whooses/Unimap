import SwiftUI

struct ExplorePage: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
    
    @FocusState private var isSearching: Bool
    @State private var path: [ExploreRoute] = []
    @State private var scrollToTab: ExploreTab? = nil
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                SearchBarComponent() { newSearch in
                    Task { await explorePageVM.updateSearch(newSearch) }
                }
                .focused($isSearching)
                
                ZStack {
                    searchingView()
                        .transition(.opacity)
                        .padding(.horizontal, 25)
                        .opacity(isSearching ? 1 : 0)
                        
                    
                    VStack {
                        SelectedTabView(selectedTab: explorePageVM.currTab) { newTab in
                            if newTab == explorePageVM.currTab {
                                scrollToTab = nil
                                withAnimation(.easeInOut) { scrollToTab = newTab }
                            }
                            else {
                                Task { await explorePageVM.updateTab(newTab) }
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        
                        ZStack {
                            AllEventSView(scrollToTab: $scrollToTab)
                                .opacity(explorePageVM.currTab == .all ? 1 : 0)
                                .allowsHitTesting(explorePageVM.currTab == .all)

                            InPersonEventsView(scrollToTab: $scrollToTab)
                                .opacity(explorePageVM.currTab == .inPerson ? 1 : 0)
                                .allowsHitTesting(explorePageVM.currTab == .inPerson)

                            OnlineEventsView(scrollToTab: $scrollToTab)
                                .opacity(explorePageVM.currTab == .online ? 1 : 0)
                                .allowsHitTesting(explorePageVM.currTab == .online)
                        }
                    }
                    .opacity(isSearching ? 0 : 1)
                }
            }
            .navigationDestination(for: ExploreRoute.self) { route in
                switch route {
                case let .profile(userID, username, pfpURL):
                    ProfilePage(username: username,
                                PFPURL: pfpURL,
                                userID: userID)
                }
            }
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            Task {
                await explorePageVM.fetchEvents()
            }
        }
    }
}

private enum ExploreRoute: Hashable {
    case profile(userID: Int, username: String, pfpURL: URL?)
}

private struct SelectedTabView: View {
    let selectedTab: ExploreTab
    let onSelectTab: ((ExploreTab) -> Void)?
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Button(action: {
                    onSelectTab?(ExploreTab.all)
                }) {
                    ZStack {
                        Text("\(ExploreTab.all.displayName)")
                            .font(.system(size: 18))
                            .fontWeight(ExploreTab.all == selectedTab ? .semibold : .medium)
                            .foregroundColor(ExploreTab.all == selectedTab ? .primary : .secondary)
                        
                        if ExploreTab.all == selectedTab {
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 35, height: 4)
                                .offset(y: 15)
                        }
                    }
                }
                
                Button(action: {
                    onSelectTab?(ExploreTab.inPerson)
                }) {
                    ZStack {
                        Text("\(ExploreTab.inPerson.displayName)")
                            .font(.system(size: 18))
                            .fontWeight(ExploreTab.inPerson == selectedTab ? .semibold : .medium)
                            .foregroundColor(ExploreTab.inPerson == selectedTab ? .primary : .secondary)
                        
                        if ExploreTab.inPerson == selectedTab {
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 35, height: 4)
                                .offset(y: 15)
                        }
                    }
                }
                
                Button(action: {
                    onSelectTab?(ExploreTab.online)
                }) {
                    ZStack {
                        Text("\(ExploreTab.online.displayName)")
                            .font(.system(size: 18))
                            .fontWeight(ExploreTab.online == selectedTab ? .semibold : .medium)
                            .foregroundColor(ExploreTab.online == selectedTab ? .primary : .secondary)
                        
                        if ExploreTab.online == selectedTab {
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 35, height: 4)
                                .offset(y: 15)
                        }
                    }
                }
            }
        }
    }
}











private struct ContentView: View {
    @StateObject private var explorePageVM = ExplorePageVM(
        schoolService: SchoolService(),
        eventService: EventService()
    )
    
    var body: some View {
        ExplorePage()
            .environmentObject(explorePageVM)
    }
}

//#Preview {
//    ContentView()
//}
