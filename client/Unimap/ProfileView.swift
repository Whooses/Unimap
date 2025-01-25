struct ProfileView: View {
    var body: some View {
        ScrollView { // Enables vertical scrolling
            VStack {
                Text("Profile Page Content")
                    .font(.title)
                    .padding()

                // Example profile details
                ForEach(1...5, id: \.self) { index in
                    Text("Profile Section \(index)")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.white)
    }
}