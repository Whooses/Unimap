import SwiftUI

// MARK: Main button - State holder
struct NewSSFilterBtn<E: StringIdentifiableEnum>: View {
    let options: [E]
    let selectedOption: E
    let sheetTitle: String
    let onSelection: ((E) -> Void)?
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {showSheet = true}) {
                buttonLabel(
                    selected: selectedOption.displayName,
                    icon: "chevron.down"
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            NewSSFilterBtnSheet(
                options: options,
                selectedOption: selectedOption,
                sheetTitle: sheetTitle,
                onSelection: onSelection
            )
        }
    }
}

// MARK: Button sheet - State modifier
private struct NewSSFilterBtnSheet<E: StringIdentifiableEnum>: View {
    let options: [E]
    let selectedOption: E
    let sheetTitle: String
    let onSelection: ((E) -> Void)?
    
    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Header
            Text("\(sheetTitle)")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)
                .padding(.top, 8)
            
            Divider()
            
            // Displaying each option
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: []) {
                    ForEach(options) { option in
                        Button {
                            if let onSelection = onSelection {
                                onSelection(option)
                            }
                            dismiss()
                        } label: {
                            OptionRow(
                                optionName: option.displayName,
                                isSelected: selectedOption == option,
                                rowHeight: rowHeight
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .presentationDetents([.height(400), .large])
    }
}

// MARK: Singular sheet's option
private struct OptionRow: View {
    let optionName: String
    let isSelected: Bool
    let rowHeight: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                .font(.title2)
            Text(optionName)
            Spacer()
        }
        .frame(height: rowHeight)
        .padding(.horizontal)
    }
}








//// MARK: - Preview
//struct NewSSFilterBtn_Previews: PreviewProvider {
//    struct PreviewWrapper: View {
//        @State private var selectedOption = Sort.latest
//        
//        var body: some View {
//            NewSSFilterBtn(
//                options: Sort.allCases,
//                selectedOption: selectedOption,
//                sheetTitle: "Select sort"
//            ) { newSelect in
//                selectedOption = newSelect
//            }
//        }
//    }
//    
//    static var previews: some View {
//        PreviewWrapper()
//            .preferredColorScheme(.light)
//    }
//}
