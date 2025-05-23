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
                    Text("\(ExploreTab.all.displayName)")
                        .font(.system(size: 18))
                        .fontWeight(ExploreTab.all == selectedTab ? .semibold : .medium)
                        .foregroundColor(ExploreTab.all == selectedTab ? .primary : .secondary)
                }
                
                Button(action: {
                    onSelectTab?(ExploreTab.inPerson)
                }) {
                    Text("\(ExploreTab.inPerson.displayName)")
                        .font(.system(size: 18))
                        .fontWeight(ExploreTab.inPerson == selectedTab ? .semibold : .medium)
                        .foregroundColor(ExploreTab.inPerson == selectedTab ? .primary : .secondary)
                }
                
                Button(action: {
                    onSelectTab?(ExploreTab.online)
                }) {
                    Text("\(ExploreTab.online.displayName)")
                        .font(.system(size: 18))
                        .fontWeight(ExploreTab.online == selectedTab ? .semibold : .medium)
                        .foregroundColor(ExploreTab.online == selectedTab ? .primary : .secondary)
                }
            }
        }
    }
}
