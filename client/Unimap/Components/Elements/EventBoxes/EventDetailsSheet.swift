import SwiftUI

struct EventDetailsSheet: View {
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
                        NavigationLink(destination: ProfilePage()) {
                            BoxHeaderComponent(pfp: pfp, username: username)
                        }
                        
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
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "bookmark")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        Image(systemName: "paperplane")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.secondary)
                        
                        
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


