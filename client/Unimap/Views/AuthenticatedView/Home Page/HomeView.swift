//
//  HomeView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//


import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                SearchBarComponent()
                    .padding(.top, 16)
                Rectangles()
                    .padding(.top, 16)
            }
        }
        .background(Color.white)
    }
}
