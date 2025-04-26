//
//  ContentView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

// UIImage+AverageColor.swift
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
//        MainView()
        
        
//        PFPComponent(
//                imageUrl: URL(string: "https://i.pravatar.cc/150?img=12"),
//                size: 45,
//                showPlusIcon: true
//            )
        
        
        testRectangleComponent(
            username: "JaneDoe",
            userPFP: PFPComponent(
                    imageUrl: URL(string: "https://i.pravatar.cc/150?img=12"),
                    size: 45,
                    showPlusIcon: true
                ),
            eventImageURL: URL(string: "https://tinyurl.com/3athtwm4"),
            eventTitle: "Birthday Party 🎉",
            eventDescription: "Join us for a fun-filled birthday bash with music and food!",
            eventDate: "April 30, 2025"
        )
        
    }
}
