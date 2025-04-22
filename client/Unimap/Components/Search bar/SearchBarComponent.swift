//
//  HomeView 2.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//


import SwiftUI

struct SearchBarComponent: View {
    @State private var searchText: String = ""

    var body: some View {
        HStack {
            // Logo image on the left
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)

            // TextField with left-aligned placeholder
            TextField("Search", text: $searchText)
                .foregroundColor(.primary)
            
            // Magnifying glass icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
        .frame(width: 350)
    }
}
