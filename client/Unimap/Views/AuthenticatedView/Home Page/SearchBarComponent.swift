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
            // Magnifying glass icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)

            // TextField for search input
            TextField("Search...", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.trailing, 8)

            // Optional: Add a cancel button (not functional yet)
            Button(action: {
                searchText = ""
            }) {
                Text("Cancel")
                    .foregroundColor(.blue)
                    .padding(.trailing, 8)
            }
        }
        .padding(.horizontal)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding()
    }
}
