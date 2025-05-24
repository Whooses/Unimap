import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second Page")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("Welcome to the Second Page!")
            .font(.largeTitle)
            .navigationTitle("Second Page")
    }
}

#Preview {
    ContentView()
}



