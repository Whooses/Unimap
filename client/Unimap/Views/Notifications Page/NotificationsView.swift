//
//  NotificationsView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ScrollView { // Enables vertical scrolling
            VStack {
                Text("Notifications Page Content")
                    .font(.title)
                    .padding()

                // Example notifications
                ForEach(1...10, id: \.self) { index in
                    Text("Notification \(index)")
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
