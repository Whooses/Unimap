import SwiftUI

struct MediumSquareCard: View {
    let username: String
    let userPFP: PFPComponent
    let eventImageURL: URL?
    let eventTitle: String
    var eventDescription: String? = ""
    let eventDate: Date?
    var eventLocation: String? = "IA 2101"
    var eventID: UUID = UUID()
    

    @State private var showSheet: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: ProfilePage()) {
                BoxHeaderComponent(
                    pfp: userPFP,
                    username: username
                )
            }

            Button (action: {showSheet.toggle()}) {
                BoxBody(
                    eventImageURL: eventImageURL,
                    eventTitle: eventTitle,
                    eventDescription: eventDescription,
                    eventDate: eventDate
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(
            isPresented: $showSheet,
            content: {
                EventDetailsSheet(
                    eventID: eventID,
                    pfp: userPFP.showPlusIcon(false),
                    username: username,
                    title: eventTitle,
                    description: eventDescription,
                    imageURL: eventImageURL,
                    date: eventDate,
                    location: eventLocation
                )
            }
        )
    }
}

private struct BoxBody: View {
    let eventImageURL: URL?
    let eventTitle: String
    let eventDescription: String?
    let eventDate: Date?
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var cardColor = Color(.systemGray)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(uiImage: imageLoaderService.image ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipped()

            Text(stringDate(Date: eventDate))
                .font(.subheadline)
                .bold()
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .foregroundColor(.white)

        }
        .background(cardColor)
        .shadow(radius: 5)
        .frame(width: 200)
        .cornerRadius(12)
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










//#Preview {
//    NavigationStack {
//        MediumSquareCard(
//            username: "Whooses",
//            userPFP: PFPComponent(
//                imageUrl: URL(string: "https://img.decrypt.co/insecure/rs:fit:3840:0:0:0/plain/https://cdn.decrypt.co/wp-content/uploads/2022/11/bored-ape-3001-bieber-gID_7.png@webp"),
//                size: 40
//            ),
//            eventImageURL: URL(string: "https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg"),
//            eventTitle: "Party Night!",
//            eventDescription: "Come join us for this year end 2025 party!",
//            eventDate: Date.now
//        )
//    }
//}
