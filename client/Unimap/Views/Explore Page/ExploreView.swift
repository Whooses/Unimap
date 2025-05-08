import SwiftUI

struct ExploreView: View {
    @State private var selectedIndex = 0
    private let titles = ["Hot", "Latest", "Upcoming"]

    // change this to whatever fixed width you like
    private let tabBarWidth: CGFloat = 300

    var body: some View {
        VStack() {
            SearchBarComponent()
                .padding(.bottom, 12)
            
            // MARK: – Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(titles.indices, id: \.self) { idx in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            selectedIndex = idx
                        }
                    }) {
                        Text(titles[idx])
                            .font(.headline)
                            .foregroundColor(selectedIndex == idx ? .primary : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: tabBarWidth)
            .overlay(
                // sliding underline
                Rectangle()
                    .fill(Color.black)
                    .frame(
                        width: 40,
                        height: 4
                    )
                    // move it by “one tab width” times the selected index
                    .offset(
                        x: CGFloat(selectedIndex) * (tabBarWidth / CGFloat(titles.count)),
                        y: 0
                    ).offset(x: 30)
                , alignment: .bottomLeading
            ).padding(.bottom, 12)

            // MARK: – Content
            Group {
                switch selectedIndex {
                case 1: LatestView()
                case 2: UpcomingView()
                default: HotView()
                }
            }
            .animation(.default, value: selectedIndex)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
