
import SwiftUI

struct UpcomingView: View {
    @State private var request: URLRequest? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .firstTextBaseline) {
                Text("Upcoming Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .padding(.leading, 25)
                Spacer()
            }
            
            FilterBarComponent()
            
            if let _ = request {
                RectangleHorLayout(
                    request: Binding(
                        get: { request! },
                        set: { request = $0 }
                    )
                )
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .onAppear {
            request = EventRequestBuilder()
                .setPath(.events)
                .build()
        }
    }
}
