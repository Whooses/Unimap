import SwiftUI

// MARK: Main button - State Holder
struct NewDRFilterBtn: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    @State private var label: String = "Date"
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
            NewDRFilterBtnSheet(
                label: $label,
                startDate: $startDate,
                endDate: $endDate
            )
        }
    }
}

// MARK: Button sheet - State Modifier
private struct NewDRFilterBtnSheet: View {
    @Binding var label: String
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    @State private var tempStartDate: Date?
    @State private var tempEndDate: Date?

    private let rowHeight: CGFloat  = 55
    private let headerHeight: CGFloat = 60

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Select Date Range")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: headerHeight)
                .padding(.horizontal)
                .padding(.top, 8)

            Divider()

            // "From" date picker
            HStack {
                Text("From").font(.headline)
                Spacer()
                DatePickerBtn(date: $tempStartDate)
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.top)

            // "To" date picker
            HStack {
                Text("To").font(.headline)
                Spacer()
                DatePickerBtn(date: $tempEndDate)
            }
            .frame(height: rowHeight)
            .padding(.horizontal)
            .padding(.bottom)

            // Apply button
            ApplyButton(
                startDate: $startDate,
                endDate: $endDate,
                label: $label,
                tempStartDate: tempStartDate,
                tempEndDate: tempEndDate
            )
            .padding(.bottom)
        }
        .presentationDetents([.height(275)])
        .onAppear {
            tempStartDate = startDate
            tempEndDate = endDate
        }
    }
}

// MARK: Date picker - State modifier
private struct DatePickerBtn: View {
    @Binding var date: Date?
    
    var body: some View {
        HStack {
            if let _ = date {
                Button {
                    date = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color.gray)
                }
            }
            
            ZStack {
                DatePicker(
                    "",
                    selection: Binding(
                        get: { date ?? Date() },
                        set: { date = $0 }
                    ),
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .blendMode(date == nil ? .destinationOver : .normal)
                
                if date == nil {
                    Text("Tap to select")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .allowsHitTesting(false)
                }
            }
        }
    }
    
}

// MARK: Apply button - State Modifier
private struct ApplyButton: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Binding var label: String
    
    let tempStartDate: Date?
    let tempEndDate: Date?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button("Apply") {
            startDate = tempStartDate
            endDate = tempEndDate
            label = dateRangeString(from: startDate, to: endDate)
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








private struct DRFilterBtnView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    
    var body: some View {
        NewDRFilterBtn(startDate: $startDate, endDate: $endDate)
    }
}

#Preview {
    DRFilterBtnView()
}
