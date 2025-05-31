import SwiftUI

struct ProfilePage: View {

    var username: String? = nil
    var PFPURL: URL? = nil
    var userID: Int = 0

    @StateObject private var imageLoader = ImageLoaderService(url: nil)
    @StateObject private var VM = ProfilePageVM(
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
                       .padding(.vertical)
                       .clipShape(Circle())

//                // Event, followers, and attended counts
//                UserInfoView(
//                    events: VM.eventsCounts,
//                    followers: VM.followerCounts,
//                    attended: VM.attendedCounts
//                )

//                // Follow and message button
//                HStack {
//                    FollowBtn() {
//
//                    }
//
//                    MessageBtn() {
//
//                    }
//                }

                // Filter and search
                HStack {
                    FilterLayout(selectedSort: VM.selectedSort) { newSort in
                        Task {
                            await VM.updateSort(newSort)
                        }
                    }

                    Spacer()

//                    SearchBtn()
                }

                // Event
                if VM.errorMessage == "No data received from server." {
                    Text("No events")
                        .foregroundColor(.secondary)
                        .offset(y: 10)
                } else if let error = VM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .offset(y: 10)
                } else {
                    RectangleVerLayout(events: VM.events)
                }
            }
            .padding(.horizontal)

        }
        .onAppear {
            VM.userID = userID
            Task {
                await withTaskGroup(of: Void.self) { group in
                    group.addTask { await imageLoader.load() }
                    group.addTask { await VM.fetchEvents() }
                }
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


//#Preview {
//    ProfilePage(
//        username: "Whooses",
//        PFPURL: URL(string: "https://upload-os-bbs.hoyolab.com/upload/2024/07/15/255898048/948a3d9cafb5a807d06a6dc5b4b81caf_7027934554437582076.jpg?x-oss-process=image%2Fresize%2Cs_1000%2Fauto-orient%2C0%2Finterlace%2C1%2Fformat%2Cwebp%2Fquality%2Cq_70")!,
//        userID: 1
//    )
//}
