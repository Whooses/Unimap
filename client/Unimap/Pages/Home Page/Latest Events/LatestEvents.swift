//
//  Recommendations.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//


//
//  Recommendations.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct Recommendations: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommendations")
                .font(.title2)
                .bold()
                .padding(.leading, 16)
                .padding(.bottom, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    // Example Event Cards
                    RecommendCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",

                        eventDate: "In 4 days"
                    )
                    RecommendCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",
                        eventDate: "In 4 days"
                    )
                    RecommendCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1",
                        eventTitle: "MATB41 Final Exam Review Seminar",
                        eventDate: "In 4 days"
                    )
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
