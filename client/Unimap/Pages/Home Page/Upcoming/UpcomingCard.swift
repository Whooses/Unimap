import SwiftUI

struct UpcomingCard: View {
    let username: String
    let userPFP: String
    let eventImage: String
    let eventTitle: String
    let eventDescription: String
    let eventDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header
            HStack {
                Image(userPFP)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(username)
                    .font(.subheadline)
                    .bold()
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.top, 8)

            // Event body
            HStack(alignment: .top, spacing: 12) {
                // Event Image
                Image(eventImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // Event Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(eventTitle)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Text(eventDescription)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    
                    Text(eventDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 8)
            
            // Bookmark Icon
            HStack {
                Spacer()
                Image(systemName: "bookmark")
                    .foregroundColor(.gray)
                    .padding(8)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.vertical, 4)
    }
}