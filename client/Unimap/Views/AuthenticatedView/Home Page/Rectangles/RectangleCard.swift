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
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())

                Text(username)
                    .font(.subheadline)
                    .bold()

                Spacer()

                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)

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
                VStack(alignment: .leading, spacing: 6) {
                    Text(eventTitle)
                        .font(.title3)
                        .lineLimit(2)
                        .truncationMode(.tail)

                    Text(eventDescription)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                        .truncationMode(.tail)

                    Text(eventDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
            }
            .frame(width: 320, height: 140) // Ensures fixed width and height
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 10)
            )
        }
        .frame(width: 320) // Ensures all cards are the same width
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }
}
