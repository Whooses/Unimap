import SwiftUI

struct SmallSquareCard: View {
    let username: String
    let userPFP: PFPComponent
    let eventImageURL: URL?
    var eventTitle: String = ""
    var eventDescription: String? = ""
    var eventDate: Date? = Date.now
    var eventLocation: String? = "IA 2101"
    var eventID: UUID = UUID()
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var showSheet: Bool = false
    @State private var showProfilePage: Bool = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Button (action: {showSheet.toggle()}) {
                ZStack(alignment: .bottom) {
                    // Background Image
                    Image(uiImage: imageLoaderService.image ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .clipped()
                    
                    // Gradient Overlay for Bottom
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.7),
                            Color.black.opacity(0.0)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .buttonStyle(PlainButtonStyle())

            // User Info
            NavigationLink(destination: ProfilePage()) {
                HStack(spacing: 8) {
                    userPFP
                    Text(username)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .bold()
                        .lineLimit(1)
                }
                .padding(8)
            }
        }
        .frame(width: 200, height: 200)
        .shadow(radius: 5)
        .onAppear {
            imageLoaderService.url = eventImageURL
            Task {
                await imageLoaderService.load()
            }
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
                    imageUI: imageLoaderService.image,
                    date: eventDate,
                    location: eventLocation,
                    showSheet: $showSheet,
                    showProfilePage: $showProfilePage
                )
            }
        )
    }
}





//#Preview {
//    NavigationStack {
//        SmallSquareCard(
//            username: "Whooses",
//            userPFP: PFPComponent(
//                imageUrl: URL(string: "https://img.decrypt.co/insecure/rs:fit:3840:0:0:0/plain/https://cdn.decrypt.co/wp-content/uploads/2022/11/bored-ape-3001-bieber-gID_7.png@webp"),
//                size: 40
//            ),
//            eventImageURL: URL(string: "https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg")
//        )
//        .background(.blue)
//    }
//}
