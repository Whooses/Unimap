//
//  ImageUploadComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-19.
//
import SwiftUI
import PhotosUI

struct ImageUploadComponent: View {
    @State private var pickerItem: PhotosPickerItem? //changes once user has selected something from their gallery
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            //image overlay 
            ZStack {
                if let image = selectedImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 315, height: 300)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                            .frame(width: 315, height: 300)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                                    .foregroundColor(.gray)
                            )
                    VStack(alignment: .center) {
                        Text("Select Image")
                            .font(.headline)
                            .padding(.bottom, 1)
                        Image(systemName:"square.and.arrow.down.fill")
                            .font(.system(size: 22, weight: .medium))
                    } .foregroundColor(.gray)
                    
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.gray, .gray]),
                        startPoint: .top,
                        endPoint: .bottom)
                    )
            )
            
            .padding(.bottom, 6)

            PhotosPicker(selection: $pickerItem, matching: .images) {
                Text("Upload Image")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
            }
            
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        
    }
}

#Preview {
    ImageUploadComponent()
}
