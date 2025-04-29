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
            AuthenticatedView(authViewModel: authViewModel)
        }
    }
}

#Preview {
//    MainView()
    RectangleComponent(
        username: "Tony",
        userPFP: PFPComponent(
            imageUrl: URL(string: "https://cdn.dribbble.com/userupload/14032542/file/original-2a6d2232e9548925c56c0fe747f43f0d.jpg?format=webp&resize=400x300&vertical=center"),
            size: 40),
        eventImageURL: URL(string: "https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg"),
        eventTitle: "Year End Party",
        eventDescription: "I want to make post",
        eventDate: "In 4 days")
}
