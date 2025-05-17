import SwiftUI

struct HotView: View {
    @ObservedObject var builder: EventRequestBuilder
    @State private var request: URLRequest?                       // parent owns optionality

    var body: some View {
        VStack(alignment: .center) {
            header
            ExploreFilterLayout(builder: builder)

            if let binding = nonOptionalRequestBinding {          // use derived binding
                RectangleVerLayout(request: binding)              // child gets non-optional
            } else {
                ProgressView()
            }

            Spacer()
        }
        .task {                                                   // main-actor safe
            request = builder.build()
        }
        .onReceive(builder.$lastUpdated) { _ in
            request = builder.build()
        }
    }

    // MARK: - Helpers

    /// `Binding<URLRequest>` only when `request` is set
    private var nonOptionalRequestBinding: Binding<URLRequest>? {
        guard request != nil else { return nil }
        return Binding(
            get: { request! },            // safe: guarded above
            set: { request = $0 }
        )
    }

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Hot Events")
                .font(.largeTitle.bold())
                .padding(.bottom, 8)
                .padding(.leading, 25)
            Spacer()
        }
    }
}
