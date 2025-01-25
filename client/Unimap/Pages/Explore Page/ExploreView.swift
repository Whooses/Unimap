//
//  ExploreView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ScrollView { // Enables vertical scrolling
            VStack {
                Text("Explore Page Content")
                    .font(.title)
                    .padding()

                // Example items
                ForEach(1...15, id: \.self) { index in
                    Text("Explore Item \(index)")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.white)
    }
}
