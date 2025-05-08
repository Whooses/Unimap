//
//  LatestEventCard.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//


import SwiftUI

struct SmallSquareCard: View {
    var username: String
    var userPFP: PFPComponent
    let eventImageURL: URL?
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var cardColor = Color(.systemGray)

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Image
            Image(uiImage: imageLoaderService.image ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200) // Square size
                .background(Color.gray)
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
                userPFP

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
        .onAppear {
            imageLoaderService.url = eventImageURL
            Task {
                await imageLoaderService.load()
                if let newColor = imageLoaderService.averageColor {
                    cardColor = newColor
                }
            }
        }
    }
}
