import SwiftUI

// MARK: Main button - State holder
struct MSFilterBtn<Item: NamedIdentifiable>: View {
    let label: String
    let options: [Item]
    let selectedOptions: [Item]
    let onSelection: (([Item]) -> Void)?
    
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
                label: label,
                options: options,
                selectedOptions: selectedOptions,
                onSelection: onSelection
            )
        }
    }
}

// MARK: Button sheet - State modifier
private struct MSFilterBtnSheet<Item: NamedIdentifiable>: View {
    let label: String
    let options: [Item]
    let selectedOptions: [Item]
    let onSelection: (([Item]) -> Void)?
    
    @State private var tempSelected: [Item] = []
    @Environment(\.dismiss) private var dismiss
    
    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60
    
    var body: some View {
        VStack {
            // Header
            Text("Select \(label)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Divider()
            
            // Displaying each option
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(options) { option in
                        Button {
                            // Toggle inside the *local* copy
                            if tempSelected.contains(option) {
                                tempSelected.removeAll { $0 == option }
                            } else {
                                tempSelected.append(option)
                            }
                        } label: {
                            OptionRow(
                                optionName: option.name,
                                isSelected: tempSelected.contains(option),
                                rowHeight: rowHeight
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            ApplyButton(tempSelected: tempSelected, onSelection: onSelection)
                .padding(.bottom)
        }
        .presentationDetents([.height(400), .large])
        .onAppear {
            tempSelected = selectedOptions
        }
    }
}

// MARK: Singular sheet option
private struct OptionRow: View {
    let optionName: String
    let isSelected: Bool
    let rowHeight: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.title2)
            Text(optionName)
            Spacer()
        }
        .frame(height: rowHeight)
        .padding(.horizontal)
    }
}

// MARK: Sheet apply button
private struct ApplyButton<Item>: View {
    let tempSelected: [Item]
    let onSelection: (([Item]) -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Apply") {
            if let onSelection = onSelection {
                onSelection(tempSelected)
            }
            dismiss()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.black)
        .foregroundColor(.white)
        .cornerRadius(15)
        .padding(.horizontal)
    }
}







//// MARK: - Sample Data Model
//struct SampleSchool: NamedIdentifiable {
//    let id: UUID = UUID()
//    let name: String
//}
//
//// MARK: - Preview
//struct MSFilterBtn_Previews: PreviewProvider {
//    struct PreviewWrapper: View {
//        @State private var selectedSchools: [SampleSchool] = []
//        
//        private let sampleSchools = [
//            SampleSchool(name: "Harvard"),
//            SampleSchool(name: "MIT"),
//            SampleSchool(name: "Stanford")
//        ]
//        
//        var body: some View {
//            MSFilterBtn(
//                label: "School",
//                options: sampleSchools,
//                selectedOptions: selectedSchools
//            ) { newSelections in
//                selectedSchools = newSelections
//            }
//        }
//    }
//    
//    static var previews: some View {
//        PreviewWrapper()
//    }
//}
