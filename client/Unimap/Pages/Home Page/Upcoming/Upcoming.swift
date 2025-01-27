//
//  Upcoming.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct Upcoming: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Upcoming")
                .font(.title2)
                .bold()
                .padding(.leading, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    // Example Event Cards
                    UpcomingCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",
                        eventDescription: "Join us for the Final Exam Review Seminar on Friday, December 13th, 2024, from 1:00 PM to 3:00 PM. We will be offering food during the break.",
                        eventDate: "In 4 days"
                    )
                    UpcomingCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",
                        eventDescription: "Join us for the Final Exam Review Seminar on Friday, December 13th, 2024, from 1:00 PM to 3:00 PM. We will be offering food during the break.",
                        eventDate: "In 4 days"
                    )
                    UpcomingCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",
                        eventDescription: "Join us for the Final Exam Review Seminar on Friday, December 13th, 2024, from 1:00 PM to 3:00 PM. We will be offering food during the break.",
                        eventDate: "In 4 days"
                    )
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
