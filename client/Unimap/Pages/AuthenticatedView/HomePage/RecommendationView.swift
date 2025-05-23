import SwiftUI

struct RecommendationView: View {
    let events: [Event]
    
    var body: some View {
        VStack {
            HStack {
                Text("Reccomendations")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading)
                Spacer()
            }
            MedSquareHorLayout(events: events)
        }
        .frame(alignment: .topLeading)
    }
}

