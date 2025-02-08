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
        AuthenticatedView(authViewModel: authViewModel)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
