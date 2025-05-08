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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
            
            NotificationsView()
                .tabItem {
                    Label("Notification", systemImage: "bell")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}
