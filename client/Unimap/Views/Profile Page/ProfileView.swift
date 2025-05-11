//
//  ProfileView.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-05.
//

import SwiftUI

struct ProfileView: View {
    
    var username: String?
    var userPFP_URL: URL?
    var followers: Int?
    var events: Int?
    var attended: Int?
    @State private var selectedFilter: String = "Latest"
    @StateObject private var imageLoader = ImageLoader(url: nil)
    
    var body: some View {
        ScrollView { // Enables vertical scrolling
            VStack(spacing: 15) {
                //Navigation Bar
                VStack {
                    HStack(alignment: .center, spacing: 15) {
                        Button {
                            //action to go back
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundStyle(.gray)
                                .font(.system(size: 22, weight: .medium))
                        }
                        Spacer()
                        //Username
                        Text(username ?? "User")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                        Button {
                            //'more' action
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray)
                                .font(.system(size: 22, weight: .medium))
                        }
                        
                    }
                }
                //Profile, buttons, info
                VStack(alignment: .center) {
                    //Profile Image
                    VStack(alignment: .center){
                        VStack{
                            Image(uiImage: imageLoader.image ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                
                            }
                            .background(Circle())
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 6)

                        //user info
                        HStack(alignment: .center, spacing: 30) {
                            profileDataView(number: events ?? 0, type: "Events")
                            profileDataView(number: followers ?? 0, type: "Followers")
                            profileDataView(number: attended ?? 0, type: "Attended")

                        } .padding(.bottom, 8)
                    }
                    
                    
                    HStack(alignment: .center, spacing: 10) {
                        Button("Follow") { /*action*/ }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 16))
                            .tint(.red)

                        Button("Message") { /*action*/ }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 16))
                            .tint(.gray)
                    }
                    .foregroundStyle(.white)
                    .fontWeight(.medium)


                } .padding(.vertical, 8)
                
                //Posts of user [lazy vstack]
                LazyVStack(spacing: 15) {
                    HStack {
                        //filter button
                        HStack{
                            Button {
                                //action to go back
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 22, weight: .medium))
                            }
                            FilterDropdown(selectedFilter: $selectedFilter)
                        }
                        Spacer()
                        //search button
                        Button {
                            //action to go back
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                                .font(.system(size: 22, weight: .medium))
                        }
                        
                    }
                    RectangleEventView()
                }
                
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


//To format number
func formatNumber(_ number: Int) -> String {
    if number < 1000 {
        return "\(number)"
    } else {
        let truncated = Double(number) / 1000.0
        let rounded = (truncated * 10).rounded() / 10  // 1 decimal point
        return "\(rounded)k"
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

#Preview {
    ProfileView()
}
