import SwiftUI

struct ProfilePage: View {

    var username: String? = nil
    var PFPURL: URL? = nil
    let userID: UUID? = UUID()

    @StateObject private var imageLoader = ImageLoaderService(url: nil)
    @StateObject private var VM = ProfilePageVM(
        userID: UUID(),
        eventService: EventService(),
        userService: UserService()
    )


    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                // Username
                Text(username ?? "user")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                // PFP
                Image(uiImage: imageLoader.image ?? UIImage(named: "stockUser")!)
                       .resizable()
                       .scaledToFill()
                       .frame(width: 100, height: 100)
                       .padding(.bottom, 6)
                       .clipShape(Circle())

                // Event, followers, and attended counts
                UserInfoView(
                    events: VM.eventsCounts,
                    followers: VM.followerCounts,
                    attended: VM.attendedCounts
                )

                // Follow and message button
                HStack {
                    FollowBtn() {

                    }

                    MessageBtn() {

                    }
                }

                // Filter and search
                HStack {
                    FilterLayout(
                        selectedSort: VM.selectedSort,
                        updateSort: VM.updateSort
                    )

                    Spacer()

                    SearchBtn()
                }

                // Event
                RectangleVerLayout(events: VM.events, showHeader: false)
            }
            .padding(.horizontal)

        }
        .onAppear {
            imageLoader.url = PFPURL
            Task {
                await imageLoader.load()
                await VM.fetchEvents()
            }
        }
    }
}

private struct UserInfoView: View {
    var events: Int = 0
    var followers: Int = 0
    var attended: Int = 0
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            ProfileDataView(number: events, type: "Event")
            ProfileDataView(number: followers, type: "Followers")
            ProfileDataView(number: attended, type: "Attended")

        } .padding(.bottom, 8)
            .padding(.leading, 10)
    }
}

private struct ProfileDataView: View {
    var number: Int
    var type: String
    var body: some View {
        VStack {
            Text(formatNumber(number))
                .font(.title)
                .foregroundStyle(.gray)
                .fontWeight(.bold)
            Text(type)
                .font(.body)
                .foregroundStyle(.gray)
                .fontWeight(.medium)
        }
    }
}

private struct FollowBtn: View {
    let followUser: (() -> Void)?

    var body: some View {
            Button(action: {followUser?()}) {
                HStack(spacing: 8) {
                    Text("Follow")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.red)
                )
            }
            .buttonStyle(PlainButtonStyle())
    }
}

private struct MessageBtn: View {
    let messageUser: (() -> Void)?

    var body: some View {
            Button(action: {messageUser?()}) {
                HStack(spacing: 8) {
                    Text("Message")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray)
                )
            }
            .buttonStyle(PlainButtonStyle())
    }
}

private struct FilterLayout: View {
    let selectedSort: Sort
    let updateSort: ((Sort) -> Void)?

    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .opacity(0.6)
            SSFilterBtn(
                options: Sort.allCases,
                selectedOption: selectedSort,
                sheetTitle: "Select Sort"
            ) { newSelect in
                updateSort?(newSelect)
            }
        }
    }
}

private struct SearchBtn: View {
    var body: some View {
        Image(systemName: "magnifyingglass")
            .padding(.trailing, 8)
    }
}


#Preview {
    ProfilePage()
}
