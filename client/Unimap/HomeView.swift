import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                SearchBarComponent()
                    .padding(.top, 16)
                
                ForEach(1...1, id: \.self) { _ in
                    HorizontalEventScroll()
                }
            }
        }
        .background(Color.white)
    }
}