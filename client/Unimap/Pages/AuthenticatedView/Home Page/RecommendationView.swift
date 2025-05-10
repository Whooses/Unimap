//
//  LatestEvents.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
import SwiftUI

struct RecommendationView: View {

    @StateObject private var eventViewModel = EventViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Reccomendation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, -2)
                    .padding(.leading, 25)
                Spacer()
            }

            MedSquareHorLayout()
        }
    }
}

