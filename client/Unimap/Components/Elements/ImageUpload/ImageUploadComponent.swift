//
//  ImageUploadComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-19.
//
import SwiftUI
import PhotosUI

struct ImageUploadComponent: View {
    @StateObject private var imgViewModel = ImgUploadViewModel()
    var body: some View {
        VStack {
            ImageSelector(selectedImage:
                            imgViewModel.selectedImage) //image selector view
            //Photos picker item
            PhotosPicker(selection: $imgViewModel.pickerItem, matching: .images) {
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
        .onChange(of: imgViewModel.pickerItem) {
            imgViewModel.loadImg() //call VM function to load image
        }
        
    }
}

struct ImageSelector: View {
    var selectedImage: Image?
    
    var body: some View {
        ZStack {
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 315, height: 300)
                    .clipped()
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
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom, 6)
    }
}

#Preview {
    ImageUploadComponent()
}
