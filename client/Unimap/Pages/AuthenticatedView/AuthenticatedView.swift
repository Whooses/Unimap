import SwiftUI

struct AuthenticatedView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ExplorePage()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            NotificationsPage()
                .tabItem {
                    Label("Notification", systemImage: "bell")
                }
            
            ProfilePage()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
