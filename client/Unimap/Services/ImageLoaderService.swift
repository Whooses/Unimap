import SwiftUI
import UIKit   // for UIColor

// 1. Add this tiny UIColor helper right above your class:
private extension UIColor {
    /// Returns this color with brightness reduced by `amount` (0…1).
    func darkened(by amount: CGFloat = 0.1) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            return self
        }
        // subtract but don’t go below 0
        return UIColor(hue: h, saturation: s, brightness: max(b - amount, 0), alpha: a)
    }
}

@MainActor
class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?
    @Published var averageColor: Color?
    
    var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() async {
        guard let url = url else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let uiImage = UIImage(data: data) else { return }
            self.image = uiImage
            
            // 2. Pick the average, darken it 10%, wrap in Color:
            let base = uiImage.averageColor ?? .gray
            let darker = base.darkened(by: 0.1)
            self.averageColor = Color(darker)
            
        } catch {
//            print("Error loading image: \(error)")
        }
    }
}
