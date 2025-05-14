import SwiftUI

struct buttonLabel: View {
    let selected: String
    let icon: String

    var body: some View {
        HStack(spacing: 8) {
            Text(selected)
                .font(.subheadline)
                .foregroundColor(.gray)

            Image(systemName: icon)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
        )
    }
}
