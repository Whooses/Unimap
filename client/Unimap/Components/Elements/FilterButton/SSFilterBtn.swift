import SwiftUI

struct SSFilterBtn: View {
    @State var label: String
    @State private var selectedOption: String?
    @State var options: [String]

    @State private var showSheet = false

    var body: some View {
        VStack {
            Button(action: {showSheet = true}) {
                buttonLabel(
                    selected: selectedOption ?? label,
                    icon: "chevron.down"
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            SSFilterBtnSheet(
                label: $label,
                selectedOption: Binding<String>(
                    get: { selectedOption ?? label },
                    set: { newValue in
                        selectedOption = newValue
                    }
                ),
                options: $options
            )
        }
    }
}

struct SSFilterBtnSheet: View {
    @Binding var label: String
    @Binding var selectedOption: String
    @Binding var options: [String]

    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Select \(label)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)
                .padding(.top, 8)

            Divider()

            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: []) {
                    ForEach(Array(options.enumerated()), id: \.element) { index, option in
                        Button {
                            selectedOption = option
                            dismiss()
                        } label: {
                            HStack {
                                Image(systemName: selectedOption == option
                                    ? "largecircle.fill.circle"
                                    : "circle"
                                )
                                .font(.title2)
                                Text(option)
                                Spacer()
                            }
                            .frame(height: rowHeight)
                            .padding(.horizontal)
                            .padding(.top, index == 0 ? 16 : 0)
                            .padding(.bottom, index == options.count - 1 ? 16 : 0)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .presentationDetents([.height(400), .large])
    }
}

//struct SSFilterBtnView: View {
//    var body: some View {
//        SSFilterBtn(
//            label: "Sort",
//            options: ["Option A", "Option B", "Option C"]
//        )
//    }
//}
//
//
//#Preview {
//    SSFilterBtnView()
//}
