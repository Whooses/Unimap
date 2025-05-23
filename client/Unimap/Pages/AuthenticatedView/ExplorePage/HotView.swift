import SwiftUI

struct HotView: View {
    @State private var request: URLRequest?                       // parent owns optionality

    var body: some View {
        VStack(alignment: .center) {
            header

            if let binding = nonOptionalRequestBinding {          // use derived binding
                RectangleVerLayout(request: binding)              // child gets non-optional
            } else {
                ProgressView()
            }

            Spacer()
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
