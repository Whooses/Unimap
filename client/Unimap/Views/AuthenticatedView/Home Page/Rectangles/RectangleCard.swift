//
//  UpcomingCard.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct RectangleCard: View {
    let username: String
    let userPFP: String
    let eventImage: String
    let eventTitle: String
    let eventDescription: String
    let eventDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                Image(userPFP)
                    .resizable()
                    .frame(width: 35, height: 30)
                    .clipShape(Circle())

                Text(username)
                    .font(.headline)
                    .bold()
            }

            // Event Content
            HStack(spacing: 0) {
                // Square Event Image
                Image(eventImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140) // Ensuring square shape
                    .clipShape(
                        .rect(
                            topLeadingRadius: 14,
                            bottomLeadingRadius: 14,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    .clipped()

                // Event Info
                VStack(alignment: .leading) {

                    Text(eventTitle)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.bottom, 10)
                    
                    Text(eventDescription)
                        .font(.footnote)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .padding(.bottom, 10)

                    Text(eventDate)
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(red: 91/255, green: 101/255, blue: 86/255))
                )
            }
            .frame(width: 350, height: 140) // Ensures fixed width and height
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(red: 91/255, green: 101/255, blue: 86/255)) // Updated color
                    .shadow(radius: 10)
            )
        }
        .frame(width: 320) // Ensures all cards are the same width
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}
