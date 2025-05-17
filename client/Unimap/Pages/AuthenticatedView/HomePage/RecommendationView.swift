//
//  LatestEvents.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
import SwiftUI

struct RecommendationView: View {
    @State private var request: URLRequest? = nil

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
            if let _ = request {
                MedSquareHorLayout(
                    request: Binding(
                        get: { request! },
                        set: { request = $0 }
                    )
                )
            } else {
                ProgressView()
            }
        }
        .onAppear {
            request = EventRequestBuilder()
                .setPath(.events)
                .build()
        }
    }
}

