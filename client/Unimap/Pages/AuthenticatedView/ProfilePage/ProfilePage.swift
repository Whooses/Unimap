//
//  ProfilePage.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-05.
//

import SwiftUI

struct ProfilePage: View {
    
    var username: String?
    var userPFP_URL: URL?
    var followers: Int?
    var events: Int?
    var attended: Int?
    @State private var selectedFilter: String = "Latest"
    @StateObject private var imageLoader = ImageLoaderService(url: nil)
    
    var body: some View {
        ScrollView { // Enables vertical scrolling
            VStack(spacing: 15) {
                //Navigation, username bar
                navUserView(userName: username ?? "User")
                
                //Profile, buttons, info
                VStack(alignment: .center) {
                    //Profile Image
                    VStack(alignment: .center) {
                        Image(uiImage: imageLoader.image ?? UIImage(named: "stockUser")!)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 100, height: 100)
                               .padding(.bottom, 6)
                               .clipShape(Circle())
                        //user info
                        userInfoView(events: events ?? 0, followers: followers ?? 0, attended: attended ?? 0)
                    } //end of vstack
                    
                    //Follow, message buttons
                    followMessageView()

                } .padding(.vertical, 8)
                
                //Posts of user [lazy vstack]
                LazyVStack(spacing: 15) {
                    //Holds the filter action, search button
                    filterSearchBarView(selectedFilter: $selectedFilter)
                    //Call the rectangle event
//                    RectangleVerLayout(request: )
                } //end of lazy v-stack
                
            } //end of wrap vstack
            .padding(.top, 8)
            .padding(.horizontal, 30)
            
        }
        .background(Color.white)
        .onAppear {
            imageLoader.url = userPFP_URL
            Task {
                await imageLoader.load()
            }
        }

    }
}

//For profile data
struct profileDataView: View {
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

//For user stats - formatted
struct userInfoView: View {
    var events: Int
    var followers: Int
    var attended: Int
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            profileDataView(number: events, type: "Events")
            profileDataView(number: followers, type: "Followers")
            profileDataView(number: attended, type: "Attended")

        } .padding(.bottom, 8)
            .padding(.leading, 10)
    }
}


//For upper navigation view
struct navUserView: View {
    var userName: String
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 15) {
                Button {
                    //action to go back
                } label: {
//                    IconButtonLabel(systemName: "chevron.backward")
                }
                Spacer()
                //Username
                Text(userName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Button {
                    //'more' action
                } label: {
//                    IconButtonLabel(systemName: "ellipsis")
                }
                
            }
        }
    }
}

//For follow, message buttons
struct followMessageView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Button("Follow") { /*action*/ }
                .tint(.red)

            Button("Message") { /*action*/ }
                .tint(.gray)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 16))
        .foregroundStyle(.white)
        .fontWeight(.medium)
    }
}

//Filter & search bar view
struct filterSearchBarView: View {
    @Binding var selectedFilter: String
    var body: some View {
        HStack {
            HStack{
                //Filter button
                Button {
                    //action to filter
                } label: {
//                    IconButtonLabel(systemName: "line.3.horizontal.decrease")
                }
                //Holds the filter dropdown button
//                FilterDropdown(selectedFilter: $selectedFilter)
            }
            Spacer()
            //Search button
            Button {
                //action to search
            } label: {
//                IconButtonLabel(systemName: "magnifyingglass")
            }
        }
    }
}

#Preview {
    ProfilePage()
}
