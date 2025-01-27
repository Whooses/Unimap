//
//  LatestEvents.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct LatestEvents: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest Events")
                .font(.title2)
                .bold()
                .padding(.leading, 16)
                .padding(.bottom, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    // Example Event Cards
                    LatestEventCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1"
                    )
                    LatestEventCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1"
                    )
                    LatestEventCard(
                        username: "AMACSS",
                        userPFP: "stockUser",
                        eventImage: "eventImage1"
                    )
                }
                .padding(.horizontal, 16)
            }
        }
    }
}
