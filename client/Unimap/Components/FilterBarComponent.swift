import SwiftUI

struct FilterBarComponent: View {
    @State private var activeFilter: Filter?
    @State private var filterSelections: [Filter: String] = [:]

    private let filterOptions: [Filter: [String]] = [
        .departments: ["All departments", "CMS", "Managements", "Life Science"],
        .clubs: ["All clubs", "AMAACS", "Google Developer", "UTSC VSA"],
        .categories: ["All categories", "Seminar", "Workshop", "Sports", "Career", "Social", "Cultural", "Religion", "RSVP", "Drop-in"]
    ]

    private let defaultBackground = Color(red: 217/255, green: 217/255, blue: 217/255)
    private let selectedBackground = Color.blue.opacity(0.2)

    private func binding(for filter: Filter) -> Binding<String> {
        Binding(
            get: { filterSelections[filter] ?? filter.rawValue },
            set: { filterSelections[filter] = $0 }
        )
    }
    
    private func fetchEvents() {
        var components = URLComponents(string: "http://127.0.0.1:8000/events")!
        var queryItems = [URLQueryItem]()
        
        if let selection = filterSelections[.departments],
           let defaultOption = filterOptions[.departments]?.first,
           selection != defaultOption {
            queryItems.append(URLQueryItem(name: "departments", value: selection.lowercased()))
        }
        if let selection = filterSelections[.clubs],
           let defaultOption = filterOptions[.clubs]?.first,
           selection != defaultOption {
            queryItems.append(URLQueryItem(name: "clubs", value: selection.lowercased()))
        }
        if let selection = filterSelections[.categories],
           let defaultOption = filterOptions[.categories]?.first,
           selection != defaultOption {
            queryItems.append(URLQueryItem(name: "categories", value: selection.lowercased()))
        }
        if let selection = filterSelections[.date],
           selection != Filter.date.rawValue {
            let parts = selection.components(separatedBy: " - ")
            if parts.count == 2 {
                let inputFormatter = DateFormatter()
                inputFormatter.dateStyle = .medium
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd"
                if let start = inputFormatter.date(from: parts[0]),
                   let end = inputFormatter.date(from: parts[1]) {
                    queryItems.append(URLQueryItem(name: "start_date", value: outputFormatter.string(from: start)))
                    queryItems.append(URLQueryItem(name: "end_date", value: outputFormatter.string(from: end)))
                }
            }
        }
        components.queryItems = queryItems
        guard let url = components.url else { return }
        
        print("API Call: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching events: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Fetched Events Response: \(responseString)")
            }
        }.resume()
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                Image("filter_icon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
                ForEach(Filter.allCases) { filter in
                    Button {
                        activeFilter = filter
                    } label: {
                        Text(filterSelections[filter] ?? filter.rawValue)
                            .foregroundColor(Color(red: 65/255, green: 65/255, blue: 65/255))
                            .padding(8)
                            .background(filterSelections[filter] != nil ? selectedBackground : defaultBackground)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 20)
        .padding(.horizontal)
        .sheet(item: $activeFilter) { filter in
            if filter.sheetType == .normal {
                NormalBottomSheetView(filter: filter, selection: binding(for: filter), options: filterOptions[filter] ?? [], onSelection: fetchEvents)
            } else {
                DateRangeSheetView(filter: filter, selection: binding(for: filter), onSelection: fetchEvents)
            }
        }
    }
}

enum SheetType {
    case normal, dateRange
}

enum Filter: String, Identifiable, CaseIterable {
    case departments = "Departments"
    case clubs = "Clubs"
    case date = "Date"
    case categories = "Categories"

    var id: String { rawValue }
    var sheetType: SheetType { self == .date ? .dateRange : .normal }
}

struct NormalBottomSheetView: View {
    let filter: Filter
    @Binding var selection: String
    let options: [String]
    var onSelection: () -> Void = {}
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Select option for \(filter.rawValue)")
                .font(.headline)
            ForEach(options, id: \.self) { option in
                Button(option) {
                    selection = option
                    onSelection()
                    dismiss()
                }
            }
            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}

struct DateRangeSheetView: View {
    let filter: Filter
    @Binding var selection: String
    var onSelection: () -> Void = {}
    @Environment(\.dismiss) private var dismiss
    @State private var startDate = Date()
    @State private var endDate = Date()

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Date Range for \(filter.rawValue)")
                .font(.headline)
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
            Button("Done") {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                selection = "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
                onSelection()
                dismiss()
            }
            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}
