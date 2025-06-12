//
//  ImgUploadViewModel.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-06-11.
//

import SwiftUI
import Foundation
import PhotosUI

class ImgUploadViewModel: ObservableObject {
    @Published var pickerItem: PhotosPickerItem? //changes once user has selected something from their gallery
    @Published var selectedImage: Image?
    
    func loadImg() {
        Task {
            do {
                if let image = try await pickerItem?.loadTransferable(type: Image.self) {
                    selectedImage = image
                } else {
                    selectedImage = nil
                }
        }
            catch {
                print("Error loading image: \(error)")
                selectedImage = nil
            }
        }
    }
}
