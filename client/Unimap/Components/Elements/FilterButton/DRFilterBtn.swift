import SwiftUI

struct DRFilterBtn: View {
    @State var label: String = "Date"
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @ObservedObject var builder: EventRequestBuilder

    @State private var showSheet = false

    var body: some View {
        VStack {
            Button(action: {showSheet = true}) {
                buttonLabel(
                    selected: label,
                    icon: "calendar"
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            DRFilterBtnSheet(label: $label, startDate: $startDate, endDate: $endDate)
        }
    }
}

struct DRFilterBtnSheet: View {
    @Binding var label: String
    @Binding var startDate: Date?
    @Binding var endDate: Date?

    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60
    @State private var vStackHeight: CGFloat = 0

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // HEADER
            Text("Select Date Range")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)

            Divider()

            HStack {
                Text("From")
                    .font(.headline)
                Spacer()
                ZStack {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { startDate ?? Date() },
                            set: { startDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                    .blendMode(startDate == nil ? .destinationOver : .normal)

                    if startDate == nil {
                        Text("Tap to select")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .allowsHitTesting(false) // Don't block touches
                    }
                }
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.top)

            HStack {
                Text("To")
                    .font(.headline)
                Spacer()
                ZStack {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { endDate ?? Date() },
                            set: { endDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                    .blendMode(endDate == nil ? .destinationOver : .normal)

                    if endDate == nil {
                        Text("Tap to select")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .allowsHitTesting(false) // Don't block touches
                    }
                }
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.bottom)


            // ACTIONS
            Button("Apply") {
                label = dateRangeString(from: startDate, to: endDate)
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.bottom)

            Button("Cancel") {
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(15)
            .padding(.horizontal)
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    // Use the new iOS 17 two-parameter onChange (with initial run)
                    .onChange(of: geo.size.height, initial: true) { newHeight, oldHeight in
                        vStackHeight = newHeight
                    }
            }
        )
        .presentationDetents([.height(vStackHeight)])
    }
}

struct DRFilterBtnView: View {
    @StateObject var builder  = EventRequestBuilder()

    var body: some View {
        DRFilterBtn(label: "Date", builder: builder)
    }
}

#Preview {
    DRFilterBtnView()
}
