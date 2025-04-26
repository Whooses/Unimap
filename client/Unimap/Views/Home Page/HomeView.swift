import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView() {
            VStack {
                SearchBarComponent()
                
                HStack {
                    Text("Reccomendation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -2)
                        .padding(.leading, 25)
                    Spacer()
                }
                SmallSquares()
                
                HStack {
                    Text("Your Upcoming")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -2)
                        .padding(.leading, 25)
                    Spacer()
                }
                
                HorizontalEventBoxDisplay()
                
                HStack {
                    Text("Latest Events")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, -2)
                        .padding(.leading, 25)
                    Spacer()
                }
                LargeSquares()
                
                Spacer()
            }
        }
    }
}
