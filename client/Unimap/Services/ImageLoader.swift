//
//  ImageLoader.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-02-04.
//

import SwiftUI

@MainActor
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var averageColor: Color?
    var url: URL?  // Removed private modifier
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() async {
        guard let url = url else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            self.image = uiImage
            self.averageColor = Color(uiImage.averageColor ?? .gray)
        } catch {
            print("Error loading image: \(error)")
        }
    }
}
