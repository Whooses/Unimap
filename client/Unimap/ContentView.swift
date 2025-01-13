import SwiftUI

// Hex color extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

// Not logged in view
struct UnauthenticatedView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("logo") // Replace with your logo image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 330)
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity)
                
                Text("Unimap")
                    .font(.custom("RobotoCondensed-Black", size: 60))
                    .foregroundColor(Color(hex: "#083162"))
                    .padding(.top, -50)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .kerning(7)
            }
            
            Spacer()
        
            // Buttons
            VStack(spacing: 20) {
                Button(action: {
                    authViewModel.login()
                }) {
                    Text("Login/ Sign up")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: 261, maxHeight: 20)
                        .padding()
                        .background(Color(hex: "#083162"))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    // Skip action
                }) {
                    Text("Skip")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.gray)
                }
            }
        
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

// Search bar component
struct SearchBarComponent: View {
    @State private var searchText: String = ""

    var body: some View {
        HStack {
            // Magnifying glass icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)

            // TextField for search input
            TextField("Search...", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.trailing, 8)

            // Optional: Add a cancel button (not functional yet)
            Button(action: {
                searchText = ""
            }) {
                Text("Cancel")
                    .foregroundColor(.blue)
                    .padding(.trailing, 8)
            }
        }
        .padding(.horizontal)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding()
    }
}

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

struct EventCardComponent: View {
    var username: String
    var userPFP: String
    var eventImage: String = "empty"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                // User PFP and Username
                HStack {
                    UserProfileComponent(imageName: userPFP, size: 40, showPlusIcon: true)
                    Text(username)
                        .font(.headline)
                }

                Spacer()

                // Triple-dot menu and Save button
                HStack(spacing: 16) {
                    Button(action: {
                        // Action for triple-dot menu
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }

                    Button(action: {
                        // Action for save button
                    }) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)

            // Event Image
            Image(eventImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(width: 191, height: 180)
        }
        .background(Color(.systemBackground))
        .frame(width: 191, height: 236)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding()
    }
}

struct HorizontalEventScroll: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                // Example Event Cards
                EventCardComponent(
                    username: "JohnDoe",
                    userPFP: "stockUser",
                    eventImage: "empty"
                )
                EventCardComponent(
                    username: "JaneDoe",
                    userPFP: "stockUser",
                    eventImage: "empty"
                )
                EventCardComponent(
                    username: "Alice",
                    userPFP: "stockUser",
                    eventImage: "empty"
                )
            }
            .padding(.horizontal, 16)
        }
    }
}


// Logged in view
struct AuthenticatedView: View {
    var body: some View {
        VStack {
            SearchBarComponent()
            HorizontalEventScroll()
        }
    }
}


// Main content
struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        if authViewModel.isAuthenticated {
            AuthenticatedView()
        } else {
            UnauthenticatedView()
        }
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
