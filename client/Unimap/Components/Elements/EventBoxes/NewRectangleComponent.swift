import SwiftUI

struct NewRectangleComponent: View {
    let username: String
    let userPFP: PFPComponent
    let eventImageURL: URL?
    let eventTitle: String
    let eventDescription: String?
    let eventDate: Date?
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
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
                Image(uiImage: imageLoaderService.image ?? UIImage())
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
                    
                    Text(stringDate(Date: eventDate))
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
            }
            .frame(width: 350, height: 140)
            .background(cardColor)
            .cornerRadius(14)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            imageLoaderService.url = eventImageURL
            Task {
                await imageLoaderService.load()
                if let newColor = imageLoaderService.averageColor {
                    cardColor = newColor
                }
            }
        }
    }
}

