import SwiftUI

struct RectangleComponent: View {
    let username: String
    let userPFP: PFPComponent
    let eventImageURL: URL?
    let eventTitle: String
    let eventDescription: String?
    let eventDate: String?
    
    @StateObject private var imageLoader = ImageLoader(url: nil)
    @State private var cardColor = Color(.systemGray)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // PFP and username
            HStack {
                userPFP
                Text(username)
                    .font(.headline)
                    .bold()
            }
            
            // Event content text
            HStack(spacing: 0) {
                // Image
                Image(uiImage: imageLoader.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140, height: 140)

                
                // Text Section
                VStack(alignment: .leading) {
                    Text(eventTitle)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.bottom, 10)
                    
                    Text(eventDescription ?? "No description")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .padding(.bottom, 10)
                    
                    Text(eventDate ?? "No date yet")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
                .background(cardColor)
            }
            .frame(width: 350, height: 140)
            .background(cardColor)
            .cornerRadius(14)
        }
        .frame(width: 320)
        .padding(.horizontal, 16)
        .onAppear {
            imageLoader.url = eventImageURL
            Task {
                await imageLoader.load()
                if let newColor = imageLoader.averageColor {
                    cardColor = newColor
                }
            }
        }
    }
}

