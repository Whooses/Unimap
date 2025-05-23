import SwiftUI

struct MediumSquareCard: View {
    var username: String
    var userPFP: PFPComponent
    var eventImageURL: URL?
    var eventTitle: String
    var eventDate: Date?
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var cardColor = Color(.systemGray)

    var body: some View {
        VStack(spacing: 10) {
            // User PFP and Username
            HStack {
                HStack {
                    userPFP

                    Text(username)
                        .font(.headline)
                        .foregroundColor(.primary)
                }

                Spacer()

                // Triple-dot menu and Save button
                HStack(spacing: 12) {
                    Button(action: {
                        // Action for triple-dot menu
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }

                    Button(action: {
                        // Action for save button
                    }) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }
                }
            }

            // Main Content
            VStack(spacing: 0) {
                // Event Image with Title Overlay
                ZStack(alignment: .bottomLeading) {
                    Image(uiImage: imageLoaderService.image ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                }
                .frame(width: 200, height: 200)

                // Footer with Date
                HStack {
                    Text(stringDate(Date: eventDate))
                        .font(.subheadline)
                        .bold()
                        .padding(.top, 8)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            .background(cardColor)
            .cornerRadius(12)
        }
        .frame(width: 200, height: 285)
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

