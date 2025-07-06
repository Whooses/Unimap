//
//  TagComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-07-06.
//

import SwiftUI

struct TagComponent: View {
    let tag: String
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 6) {
            Text(tag)
                .font(.footnote.bold())
                .foregroundColor(Color.black.opacity(0.69))
                .lineLimit(1)
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.gray)
                    .font(.footnote)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.8))
        )

    }
}
