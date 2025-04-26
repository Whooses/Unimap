import SwiftUI

struct LatestView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .firstTextBaseline) {
                Text("Latest Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 25)
                Spacer()
            }
            
            FilterBarComponent()
            
            EventBoxDisplay()

            Spacer()
        }
    }
}

