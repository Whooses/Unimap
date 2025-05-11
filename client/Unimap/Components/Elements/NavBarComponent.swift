import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home Screen")
                    .padding()

                NavigationLink("Go to Details", destination: DetailView())
            }
            .navigationTitle("Home")
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail Screen")
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline) // Optional: makes title smaller
    }
}

#Preview {
    ContentView()
}
