import SwiftUI

struct LastestEventsView: View {
    @State private var request: URLRequest? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Latest Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }
            
            
            if let _ = request {
                SmallSquareHorLayout(
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
