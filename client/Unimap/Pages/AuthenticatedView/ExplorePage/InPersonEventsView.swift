import SwiftUI

struct InPersonEventsView: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
    @Binding var scrollToTab: ExploreTab?
 
    var body: some View {
        ScrollView {
            
            Color.clear.frame(height: 1)
                .id(ExploreTab.inPerson)
            
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section {
                    HStack(alignment: .firstTextBaseline) {
                        Text("In person events")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 8)
                            .padding(.leading)
                        Spacer()
                    }
                }
                Section {
                    if explorePageVM.errorMessage == "No data received from server." {
                        Text("No events")
                            .foregroundColor(.secondary)
                            .offset(y: 10)
                    } else if let error = explorePageVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .offset(y: 10)
                    } else {
                        RectangleVerLayout(events: explorePageVM.events[.inPerson]) {
                            Task {
                                await explorePageVM.fetchMoreEvents()
                            }
                        }
                    }
                    
                    Spacer()
                } header: {
                    ExploreFilterLayout()
                }
                
            }
        }
        .scrollTargetLayout()
        .scrollPosition(id: $scrollToTab, anchor: .top)
        .refreshable {
            Task {
                explorePageVM.clearEventData()
                
                await explorePageVM.fetchEvents()
            }
        }
    }
}

//#Preview {
//    AllEventSView()
//}

