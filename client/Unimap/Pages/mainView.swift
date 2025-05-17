import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
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

