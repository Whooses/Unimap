//
//  ContentView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)

        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// UIImage+AverageColor.swift
import UIKit

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extent = inputImage.extent
        let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: CIVector(cgRect: extent)])!
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255,
            green: CGFloat(bitmap[1]) / 255,
            blue: CGFloat(bitmap[2]) / 255,
            alpha: CGFloat(bitmap[3]) / 255
        )
    }
}


struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
//        if authViewModel.isAuthenticated {
            AuthenticatedView(authViewModel: authViewModel)
//        } else {
//            UnauthenticatedView(authViewModel: authViewModel)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
