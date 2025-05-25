import SwiftUI

struct RectangleComponent: View {
    let username: String
    let userPFP: PFPComponent
    let eventImageURL: URL?
    let eventTitle: String
    var eventDescription: String? = ""
    let eventDate: Date?
    var eventLocation: String? = "IA 2101"
    var eventID: UUID = UUID()
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var cardColor = Color(.systemGray)
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
                    .lineLimit(1)
                    .padding(.bottom, 10)
                
                Text(eventDescription ?? "No description")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding(.bottom, 10)
                
                Text(stringDate(Date: eventDate))
                    .font(.caption)
                    .lineLimit(3)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
        }
        .background(cardColor)
        .frame(width: 350, height: 140)
        .cornerRadius(14)
        .shadow(radius: 5)
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
//        RectangleComponent(
//            username: "Whooses",
//            userPFP: PFPComponent(imageUrl: URL(string: "https://img.decrypt.co/insecure/rs:fit:3840:0:0:0/plain/https://cdn.decrypt.co/wp-content/uploads/2022/11/bored-ape-3001-bieber-gID_7.png@webp"), size: 40),
//            eventImageURL: URL(string: "https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg"),
//            eventTitle: "Year End Party!",
//            eventDescription: "Come join us for this year end 2025 party!",
//            eventDate: Date.now,
//        )
//    }
//}

