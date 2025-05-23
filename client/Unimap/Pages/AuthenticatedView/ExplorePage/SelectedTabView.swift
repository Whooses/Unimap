import SwiftUI

struct SelectedTabView: View {
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
                    }                }
                
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
