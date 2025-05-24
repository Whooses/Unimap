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
            boxHeader(
                pfp: userPFP,
                username: username
            )
            
            Button (action: {showSheet.toggle()}) {
                boxBody(
                    eventImageURL: eventImageURL,
                    eventTitle: eventTitle,
                    eventDescription: eventDescription,
                    eventDate: eventDate,
                    eventID: eventID,
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: .infinity)
        .sheet(
            isPresented: $showSheet,
            content: {
                eventDetails(
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

private struct boxHeader: View {
    let pfp: PFPComponent
    let username: String
    
    var body: some View {
        HStack {
            pfp
            Text(username)
                .font(.headline)
                .bold()
        }
    }
}

private struct boxBody: View {
    let eventImageURL: URL?
    let eventTitle: String
    let eventDescription: String?
    let eventDate: Date?
    let eventID: UUID
    
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

private struct eventDetails: View {
    let eventID: UUID
    let pfp: PFPComponent
    let username: String
    let title: String?
    let description: String?
    let imageURL: URL?
    let date: Date?
    let location: String?
    
    private let rowHeight: CGFloat = 55
    private let headerHeight: CGFloat = 60
    
    private let VM: EventDetailsVM = EventDetailsVM(eventSerive: EventService())
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Header
                    HStack(spacing: 10) {
                        boxHeader(pfp: pfp, username: username)
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 5))
                            .offset(y: 1)
                        
                        Text("Follow")
                            .font(.headline)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 2)
                            .foregroundColor(.red)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                        
                        
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Image(systemName: "bookmark")
                            .font(.system(size: 20, weight: .semibold))
                        
                        Image(systemName: "paperplane")
                            .font(.system(size: 20, weight: .semibold))
                        
                        
                    }
                    .padding(.top, 8)
                    .frame(height: headerHeight)
                    
                    Text(title ?? "")
                        .font(.title)
                        .bold()
                        .lineLimit(1)
                        .offset(y: -10)
                    
                    
                    Text(description ?? "No description")
                        .font(.system(size: 17))
                        .lineLimit(3)
                    
                    HStack {
                        Image(systemName: "chevron.down")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
                    .padding(.bottom, 2)
                    
                    Divider()
                    HStack {
                        Text("When")
                        Spacer()
                        Text(stringDate(Date: date))
                    }
                    
                    Divider()
                    HStack {
                        Text("Where")
                        Spacer()
                        Text(location ?? "Location undecided")
                    }
                    
                    Divider()
                    HStack {
                        Text("People attending")
                        Spacer()
                        Text("No one")
                        
                    }
                    
                    HStack {
                        Spacer()
                        Image(uiImage: imageLoaderService.image ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 320)
                            .clipped()
                            .cornerRadius(20)
                        Spacer()
                    }
                    .padding()
                    
                    Divider()
                    HStack {
                        Text("Similar events")
                        Spacer()
                    }
                    
                    
                    
                    Spacer()
                }
                .presentationDetents([.height(400), .large])
                .padding(.horizontal)
                .onAppear {
                    Task {
                        await VM.loadEventDetails(id: eventID)
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack(spacing: 30) {
                    Text(stringDate(Date: date))
                    Text("Attend")
                        .font(.headline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                    Text("IA 2101")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(.white)
                .padding(.top)
                .background(
                    Color.white
                        .shadow(color: Color.gray.opacity(0.2), radius: 5, y: -6)
                        .mask {
                            Rectangle().padding(.top, -20)
                        }
                )

            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            imageLoaderService.url = imageURL
            Task {
                await imageLoaderService.load()
            }
        }
    }
}





#Preview {
    RectangleComponent(
        username: "Whooses",
        userPFP: PFPComponent(imageUrl: URL(string: "https://img.decrypt.co/insecure/rs:fit:3840:0:0:0/plain/https://cdn.decrypt.co/wp-content/uploads/2022/11/bored-ape-3001-bieber-gID_7.png@webp"), size: 40),
        eventImageURL: URL(string: "https://marketplace.canva.com/EAFJMl8KcjI/1/0/1131w/canva-purple-black-tropical-party-club-poster-orVwDS2lrfY.jpg"),
        eventTitle: "Year End Part",
        eventDescription: "Come join us for this year end 2025 party!",
        eventDate: Date.now,
    )
}

