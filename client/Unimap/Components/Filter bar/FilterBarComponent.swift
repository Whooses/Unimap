import SwiftUI

struct FilterBarComponent: View {
    @State private var activeFilter: Filter?
    @State private var filterSelections: [Filter: String] = [:]
    @State private var events: [Event] = []
    @State private var errorMessage: String?

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
        if let apiURL = APIHelper.buildAPIUrl(filterSelections: filterSelections, filterOptions: filterOptions) {
            let urlString = apiURL.absoluteString
            print("Using API URL: \(urlString)")
            EventService().loadEvents(from: urlString) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let fetchedEvents):
                        print("Fetched infos: \(fetchedEvents)")
                        self.events = fetchedEvents
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print("Failed to load events: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("Failed to build API URL")
        }
    }
    
    var body: some View {
        VStack {
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
            
            if !events.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 5) {
                        ForEach(events) { event in
                            RectangleCard(
                                username: event.username,
                                userPFP: "stockUser",
                                eventImageURL: URL(string: event.image_url),
                                eventTitle: event.title,
                                eventDescription: event.description,
                                eventDate: event.date
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            }
        }
        .onAppear(perform: fetchEvents)
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
