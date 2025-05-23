import SwiftUI

// MARK: – Button that opens the sheet
struct MSFilterBtn: View {
    @State var label: String
    @State var options: [String]
    @ObservedObject var builder: EventRequestBuilder

    @State private var selectedOptions: [String] = []
    @State private var showSheet = false

    var body: some View {
        VStack {
            Button { showSheet = true } label: {
                buttonLabel(selected: label, icon: "chevron.down")
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

// MARK: – Sheet
struct MSFilterBtnSheet: View {
    @Binding var options: [String]
    @Binding var selectedOptions: [String]
    @ObservedObject var builder: EventRequestBuilder

    // Work-in-progress copy; starts equal to selectedOptions
    @State private var tempSelected: [String] = []

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

            // List
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            // Toggle inside the *local* copy
                            if tempSelected.contains(option) {
                                tempSelected.removeAll { $0 == option }
                            } else {
                                tempSelected.append(option)
                            }
                        } label: {
                            HStack {
                                Image(systemName: tempSelected.contains(option)
                                      ? "checkmark.circle.fill"
                                      : "circle")
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

            // ACTIONS
            Button("Apply") {
                selectedOptions = tempSelected

                let clubs = selectedOptions.compactMap {
                    EventRequestBuilder.Club(caseInsensitive: $0)
                }
                _ = builder.setClubs(clubs)

                dismiss()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.bottom)

//            Button("Cancel") { dismiss() }
//                .frame(maxWidth: .infinity)
//                .frame(height: 50)
//                .background(Color.white)
//                .foregroundColor(.black)
//                .cornerRadius(15)
//                .padding(.horizontal)
        }
        .onAppear {
            tempSelected = selectedOptions
        }
        .presentationDetents([.height(400), .large])
    }
}

//// MARK: – Preview harness
//private struct ContentView: View {
//    @StateObject var builder = EventRequestBuilder()
//
//    var body: some View {
//        MSFilterBtn(
//            label: "Clubs",
//            options: ["Option A", "Option B", "Option C",
//                      "Option D", "Option E", "Option F",
//                      "Option G", "Option H", "Option I"],
//            builder: builder
//        )
//    }
//}
//
//#Preview { ContentView() }
