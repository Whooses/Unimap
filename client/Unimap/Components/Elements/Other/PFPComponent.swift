//
//  PFPComponent.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//
import SwiftUI

struct PFPComponent: View {
    /// The URL of the profile image.
    let imageUrl: URL?
    /// Diameter of the profile circle.
    var size: CGFloat = 80
    /// Toggle to show the plus icon overlay.
    var showPlusIcon: Bool = true
    /// Placeholder image shown while loading or on failure.
    var placeholder: Image = Image(systemName: "person.crop.circle.fill")
    /// Border color around the circle.
    var borderColor: Color = .white
    /// Border line width.
    var borderWidth: CGFloat = 2
    /// Color of the plus icon.
    var plusIconColor: Color = .red
    /// Background color behind the plus icon.
    var plusBackgroundColor: Color = .white
    /// Size factor for the plus icon relative to the main circle.
    private var plusSizeFactor: CGFloat { 0.4 }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Load the image asynchronously
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    placeholder
                        .resizable()
                        .scaledToFill()
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        )
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                        .resizable()
                        .scaledToFill()
                @unknown default:
                    placeholder
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(borderColor, lineWidth: borderWidth))

            // Optional plus/edit icon overlay
            if showPlusIcon {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: size * plusSizeFactor, height: size * plusSizeFactor)
                    .foregroundColor(plusIconColor)
                    .background(
                        Circle()
                            .fill(plusBackgroundColor)
                            .frame(width: size * plusSizeFactor, height: size * plusSizeFactor)
                    )
                    .offset(x: size * 0.05, y: size * 0.05)
            }
        }
    }
    
    func showPlusIcon(_ showPlusIcon: Bool) -> PFPComponent {
        var copy = self
        copy.showPlusIcon = showPlusIcon
        return copy
    }
}


