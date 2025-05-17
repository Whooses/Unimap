import SwiftUI

struct MSFilterBtn: View {
    @State var label: String
    @State var options: [String]
    @ObservedObject var builder: EventRequestBuilder

    @State private var selectedOptions: [String] = []
    @State private var showSheet = false

    var body: some View {
        VStack {
            Button(action: {showSheet = true}) {
                buttonLabel(
                    selected: label,
                    icon: "chevron.down"
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            MSFilterBtnSheet(
                options: $options,
                selectedOptions: $selectedOptions,
                builder: builder
            )
        }
    }
}

struct MSFilterBtnSheet: View {
    @Binding var options: [String]
    @Binding var selectedOptions: [String]
    @ObservedObject var builder: EventRequestBuilder

    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Select Clubs")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)
                .padding(.top, 8)

            Divider()

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            // 1️⃣ toggle the option in/out of the array
                            if selectedOptions.contains(option) {
                                selectedOptions.removeAll { $0 == option }
                            } else {
                                selectedOptions.append(option)
                            }

                            // 2️⃣ build the enum list in a case-insensitive way
                            let selectedClubs = selectedOptions.compactMap {
                                EventRequestBuilder.Club(caseInsensitive: $0)   // ← use the new init
                            }
                            _ = builder.setClubs(selectedClubs)
                        } label: {
                            HStack {
                                Image(systemName: selectedOptions.contains(option)
                                    ? "checkmark.circle.fill"
                                    : "circle"
                                )
                                .font(.title2)
                                Text(option)
                                Spacer()
                            }
                            .frame(height: rowHeight)
                            .padding(.horizontal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.top)
            }

        }
        .presentationDetents([.height(400), .large])
    }
}


//struct MSFilterBtnView: View {
//    @StateObject var builder  = EventRequestBuilder()
//
//    var body: some View {
//        MSFilterBtn(
//            label: "Clubs",
//            options: ["Option A", "Option B", "Option C"],
//            builder: builder
//        )
//    }
//}
//
//
//#Preview {
//    MSFilterBtnView()
//}

