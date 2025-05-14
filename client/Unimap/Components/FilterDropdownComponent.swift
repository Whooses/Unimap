//
//  FilterDropdownComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-05.
//

import SwiftUI

struct FilterDropdown: View {
    @Binding var selectedFilter: String
    @State private var showSheet: Bool = false
    let filters = ["Latest", "Popular", "Upcoming", "Past"]

    var body: some View {
        Button(action: {
            showSheet = true
        }) {
            HStack(spacing: 4) {
                Text(selectedFilter)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.down")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
        } .sheet(isPresented: $showSheet) {
            FilterOptionsSheet(selectedFilter: $selectedFilter, options: filters)
                .presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    FilterDropdown(selectedFilter: .constant("Latest"))
}
