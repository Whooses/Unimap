import SwiftUI

struct YourUpcomingView: View {
    @State private var request: URLRequest? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Your Upcoming")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }
            
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
        }
        .onAppear {
            request = EventRequestBuilder()
                .setPath(.events)
                .build()
        }
    }
}
