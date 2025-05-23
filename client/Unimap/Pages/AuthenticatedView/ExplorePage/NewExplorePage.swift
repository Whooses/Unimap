import SwiftUI

struct NewExplorePage: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
    
    @FocusState private var isSearching: Bool
    
    var body: some View {
        VStack {
            NewSearchBarComponent(searchText: $explorePageVM.search)
                .focused($isSearching)
                        
            ZStack {
                if isSearching {
                    searchingView()
                    .transition(.opacity)
                    .padding(.horizontal, 25)

                } else {
                    VStack {
                        SelectedTabView(selectedTab: explorePageVM.currTab) { newTab in
                            explorePageVM.currTab = newTab
                        }
                        .padding(.top)
                        
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
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(.white)
        .onAppear {
            Task {
                await explorePageVM.fetchEvents()
            }
        }
    }
}





//private struct ExploreWrapper: View {
//    @StateObject private var explorePageVM = ExplorePageVM(
//        schoolService: SchoolService(),
//        eventService: NewEventService()
//    )
//    
//    var body: some View {
//        NewExplorePage()
//            .environmentObject(explorePageVM)
//    }
//}
//
//
//
//#Preview {
//    ExploreWrapper()
//}
