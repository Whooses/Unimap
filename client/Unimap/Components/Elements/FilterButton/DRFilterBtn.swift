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
            DRFilterBtnSheet(
                label: $label,
                startDate: $startDate,
                endDate: $endDate,
                builder: builder
            )
        }
    }
}

struct DRFilterBtnSheet: View {
    @Binding var label: String
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @ObservedObject var builder: EventRequestBuilder

    private let rowHeight: CGFloat  = 55
    private let headerHeight: CGFloat = 60
    @State private var vStackHeight: CGFloat = 0

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // ── HEADER ─────────────────────────────────────────────
            ZStack {
                Text("Select Date Range")
                    .font(.headline)
                    .frame(height: headerHeight)

                HStack {
                    Spacer()
                    Button("Clear") {          // ←-- FIX ①
                        // reset all state back to “empty”
                        startDate = nil
                        endDate = nil
                        label = "Date"
                        builder.setDateRange(start: nil, end: nil)
                        dismiss()
                    }
                    .font(.callout)
                    .foregroundColor(.secondary)
                }
            }
            .frame(height: headerHeight)
            .padding(.horizontal, 40)

            Divider()

            // ── FROM ───────────────────────────────────────────────
            HStack {
                Text("From").font(.headline)
                Spacer()
                ZStack {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { startDate ?? Date() },
                            set: { startDate = $0 }  // ←-- stays the same
                        ),
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                    .blendMode(startDate == nil ? .destinationOver : .normal)

                    if startDate == nil {
                        Text("Tap to select")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .allowsHitTesting(false)
                    }
                }
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.top)

            // ── TO ────────────────────────────────────────────────
            HStack {
                Text("To").font(.headline)
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
                            .allowsHitTesting(false)
                    }
                }
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.bottom)

            // ── APPLY ─────────────────────────────────────────────
            Button("Apply") {
                builder.setDateRange(start: startDate, end: endDate)
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
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .onChange(of: geo.size.height, initial: true) { newHeight, _ in
                        vStackHeight = newHeight
                    }
            }
        )
        // give SwiftUI a non-zero fallback the first time
        .presentationDetents([.height(max(vStackHeight, 300))])
    }
}


//struct DRFilterBtnView: View {
//    @StateObject var builder  = EventRequestBuilder()
//
//    var body: some View {
//        DRFilterBtn(label: "Date", builder: builder)
//    }
//}
//
//#Preview {
//    DRFilterBtnView()
//}
