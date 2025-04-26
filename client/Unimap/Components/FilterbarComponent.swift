import SwiftUI

struct FilterBarComponent: View {
    // Example filter categories
    let filters = ["All", "Favorites", "Recent", "Nearby"]
    
    @State private var selectedFilter: String = "All"
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Custom-styled filter bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            selectedFilter = filter
                            showSheet = true
                        }) {
                            HStack(spacing: 4) {
                                Text(filter)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.down")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showSheet) {
                FilterOptionsSheet(selectedFilter: $selectedFilter)
                    .presentationDetents([.medium, .large])
            }
            .padding(.leading, 13)
        }
    }
}

// Bottom sheet view remains unchanged
struct FilterOptionsSheet: View {
    @Binding var selectedFilter: String
    @Environment(\.presentationMode) var presentationMode
    
    var options = ["All", "Favorites", "Recent", "Nearby", "Trending", "Recommended"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose a Filter")) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedFilter = option
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(option)
                                if selectedFilter == option {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Filter Options")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

