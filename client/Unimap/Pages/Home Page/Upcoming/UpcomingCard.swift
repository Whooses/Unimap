//
//  UpcomingCard.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct UpcomingCard: View {
    let username: String
    let userPFP: String
    let eventImage: String
    let eventTitle: String
    let eventDescription: String
    let eventDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Increased spacing slightly
            // Header (Username and Profile Picture)
            HStack {
                Image(userPFP)
                    .resizable()
                    .frame(width: 30, height: 30) // Increased size
                    .clipShape(Circle())

                Text(username)
                    .font(.subheadline)
                    .bold()

                Spacer()

                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20) // Increased padding slightly

            // Event Body
            HStack(spacing: 0) {
                // Event Image (takes 35% width with rounded corners)
                Image(eventImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.35, height: 140) // Scaled up proportionally
                    .clipShape(
                        .rect(
                            topLeadingRadius: 14,
                            bottomLeadingRadius: 14,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    .clipped()

                // Event Info (takes remaining space)
                VStack(alignment: .leading, spacing: 10) { // Increased spacing slightly
                    Text(eventTitle)
                        .font(.title3) // Slightly larger font
                        .lineLimit(2)

                    Text(eventDescription)
                        .font(.footnote) // Adjusted font size to balance scale
                        .foregroundColor(.gray)
                        .lineLimit(3)

                    Text(eventDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(16) // Increased padding slightly
            }
            .background(
                RoundedRectangle(cornerRadius: 14) // Increased corner radius
                    .fill(Color(.systemBackground))
                    .shadow(radius: 10) // Increased shadow for emphasis
            )
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.9) // Slightly larger card width
        .padding(.vertical, 10) // Added vertical padding between cards
    }
}
