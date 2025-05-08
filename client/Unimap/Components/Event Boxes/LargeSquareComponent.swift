//
//  LargeSquareComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-02.
//

import SwiftUI

struct LargeSquareComponent: View {
    var username: String
    var userPFP: PFPComponent
    var eventImageURL: URL?
    var eventTitle: String
    var eventDesc: String?
    var eventDate: String?
    
    @StateObject private var imageLoaderService = ImageLoaderService(url: nil)
    @State private var cardColor = Color(.systemGray)


    var body: some View {
        //wrapped in Vstack
        VStack(spacing: 10) {
            //Header - HStack
            HStack(alignment: .center) {
                userPFP
                Text(username)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                //Post buttons
                HStack(alignment: .center, spacing: 15) {
                    Button {
                        //action to send
                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.gray)
                            .font(.system(size: 22, weight: .medium))
                    }
                    Button {
                        //action to save
                    } label: {
                        Image(systemName: "bookmark")
                            .foregroundStyle(.gray)
                            .font(.system(size: 22, weight: .medium))
                    }
                    Button {
                        //action for more
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.gray)
                            .font(.system(size: 22, weight: .medium))
                    }
                    
                }
                .padding(5)
            }
            .padding(.horizontal, 10)
            
            //Image
            VStack {
                Image(uiImage: imageLoaderService.image ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .frame(width: 315, height: 300)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(gradient: Gradient(colors: [cardColor, .black]), startPoint: .top, endPoint: .bottom))
            )
            .padding(.bottom, 6)
            
            //Information
            VStack(alignment: .leading, spacing: 10) {
                //Title
                VStack(alignment: .leading, spacing: 4) {
                Text(eventTitle)
                    .font(.title3)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                //Description
                Text(eventDesc ?? "No description")
                    .font(.subheadline)
                    .lineLimit(3)
                    .minimumScaleFactor(0.8)
                    .truncationMode(.tail)
               }
                
                //Date
                Text(eventDate ?? "No date yet")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.gray.opacity(0.7), radius: 7)
        ) //forms the rounded card
        .padding(.horizontal, 24)
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
//    LargeSquareComponent(username: "Test", userPFP: PFPComponent(imageUrl: nil, size: 40), eventImageURL: nil, eventTitle: "MATB24 Review Seminar")
//}

