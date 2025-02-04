//
//  LatestEventCard.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//


import SwiftUI

struct LargeSquaresCard: View {
    var username: String
    var userPFP: String
    var eventImage: String = "empty"

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image
            Image(eventImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200) // Square size
                .clipShape(RoundedRectangle(cornerRadius: 16)) // Curved square shape
                .clipped()

            // Gradient Overlay for Bottom
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.7),
                    Color.black.opacity(0.0)
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 16)) // Match shape to image

            // User Info
            HStack(spacing: 8) {
                // User PFP
                Image(userPFP)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                // Username
                Text(username)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
            }
            .padding(8) // Padding for username and PFP
        }
        .frame(width: 200, height: 200) // Ensure consistent square size
        .shadow(radius: 5) // Shadow for elevation
        .padding(16)
    }
}
