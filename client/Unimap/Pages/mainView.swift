import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var explorePageVM = ExplorePageVM(
        schoolService: SchoolService(),
        eventService: EventService()
    )

    var body: some View {
        if (authViewModel.isAuthenticated == true) {
            AuthenticatedView(authViewModel: authViewModel)
                .environmentObject(explorePageVM)
        }
        else {
            UnauthenticatedView(authViewModel: authViewModel)
        }
    }
}

//#Preview {
//    MainView()
//}

