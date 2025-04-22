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
                FilterBarComponent()
                EventBoxHorizontal()
            }
        }
        .background(Color.white)
    }
}
