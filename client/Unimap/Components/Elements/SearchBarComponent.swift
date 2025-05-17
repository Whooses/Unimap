import SwiftUI

struct SearchBarComponent: View {
    @State private var searchText = ""
    @ObservedObject var builder: EventRequestBuilder

    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            TextField("Search", text: $searchText)
                .foregroundColor(.primary)
                // Show “Search” on software keyboard (optional)
                .submitLabel(.search)
                // 👇 Update the builder only when the user submits
                .onSubmit {
                    _ = builder
                        .setSearch(searchText)
                }

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding(.trailing, 17)
        .padding(.leading, 5)
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 25)
    }
}
