import SwiftUI

// MARK: Main button - State holder
struct NewSSFilterBtn<E: StringIdentifiableEnum>: View {
    let options: [E]
    let sheetTitle: String
    
    @Binding var label: String
    
    @State private var showSheet: Bool = false
    
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
            NewSSFilterBtnSheet(
                label: $label,
                sheetTitle: sheetTitle,
                options: options
            )
        }
    }
}

// MARK: Button sheet - State modifier
private struct NewSSFilterBtnSheet<E: StringIdentifiableEnum>: View {
    @Binding var label: String
    
    let sheetTitle: String
    let options: [E]
    
    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            // Header
            Text("Select \(sheetTitle)")
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
                            label = option.rawValue
                            dismiss()
                        } label: {
                            OptionRow(
                                optionName: option.rawValue,
                                isSelected: label == option.rawValue,
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








//// MARK: - Sample enum for the preview
//private enum SampleFilter: String, StringIdentifiableEnum {
//    case apple, banana, cherry
//    var id: String { rawValue }
//}
//
//// MARK: - Preview
//struct NewSSFilterBtn_Previews: PreviewProvider {
//    struct PreviewWrapper: View {
//        @State private var selected = SampleFilter.apple.rawValue
//        
//        var body: some View {
//            NewSSFilterBtn<SampleFilter>(
//                options: SampleFilter.allCases,
//                sheetTitle: "Fruit",
//                label: $selected
//            )
//            .padding()
//            .previewLayout(.sizeThatFits)
//        }
//    }
//    
//    static var previews: some View {
//        PreviewWrapper()
//            .preferredColorScheme(.light)
//    }
//}
