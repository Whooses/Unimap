// Account pfp component
struct UserProfileComponent: View {
    var imageName: String // Name of the profile image in assets
    var size: CGFloat = 80 // Default size of the profile circle
    var showPlusIcon: Bool = true // Toggle for the plus icon

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Profile Picture Circle
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Add a border

            // Plus Icon Circle (for unfollowed state)
            if showPlusIcon {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: size * 0.4, height: size * 0.4)
                    .foregroundColor(.red) // Customize the color
                    .background(Color.white) // White background for the plus icon
                    .clipShape(Circle())
                    .offset(x: size * 0.05, y: size * 0.05) // Position the plus icon
            }
        }
    }
}