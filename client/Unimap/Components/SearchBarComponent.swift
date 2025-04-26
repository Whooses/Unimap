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
        .padding(.trailing, 17)
        .padding(.leading, 5)
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 25) // 20 points gap on left and right
    }
}
