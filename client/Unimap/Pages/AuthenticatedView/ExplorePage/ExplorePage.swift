import SwiftUI

struct ExplorePage: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
    
    @FocusState private var isSearching: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarComponent() { newSearch in
                    Task {
                        await explorePageVM.updateSearch(newSearch)
                    }
                    
                }
                    .focused($isSearching)
                
                ZStack {
                    if isSearching {
                        searchingView()
                            .transition(.opacity)
                            .padding(.horizontal, 25)
                        
                    } else {
                        VStack {
                            SelectedTabView(selectedTab: explorePageVM.currTab) { newTab in
                                Task {
                                    await explorePageVM.updateTab(newTab)
                                }
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 10)
                            
                            TabView(selection: $explorePageVM.currTab) {
                                AllEventSView()
                                    .tag(ExploreTab.all)
                                
                                InPersonEventsView()
                                    .tag(ExploreTab.inPerson)
                                
                                OnlineEventsView()
                                    .tag(ExploreTab.online)
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            
                        }
                    }
                }
                
//                Spacer()
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

#Preview {
    ContentView()
}
