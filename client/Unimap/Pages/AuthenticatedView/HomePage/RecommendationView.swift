import SwiftUI

struct RecommendationView: View {
    let events: [NewEvent]
    
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
            NewMedSquareHorLayout(events: events)
        }
        .frame(alignment: .topLeading)
    }
}

