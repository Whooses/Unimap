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
        MainView()
        
    }
}
