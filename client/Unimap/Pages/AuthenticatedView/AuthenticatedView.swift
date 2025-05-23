//
//  AuthenticatedView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-27.
//


import SwiftUI

struct AuthenticatedView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            NewHomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            NewExplorePage()
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
