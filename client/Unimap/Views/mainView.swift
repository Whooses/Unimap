import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        // Auth model is currently set as true for development purpose
        // It is suppose to stay false until getting verfied
        // by the user.
        if (authViewModel.isAuthenticated == true) {
            AuthenticatedView(authViewModel: authViewModel)
        }
        else {
            UnauthenticatedView(authViewModel: authViewModel)
        }
    }
}

//#Preview {
//    MainView()
//}
