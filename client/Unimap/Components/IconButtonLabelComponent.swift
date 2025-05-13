//
//  IconButtonLabelComponent.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-12.
//

import SwiftUI

struct IconButtonLabel: View {
    //Creates the 'icon' buttons, i.e. the buttons using SF symbols such as search, etc
    //Can modify values such as colour, 'font' weight and size
    var systemName: String
    var color: Color = .gray
    var size: CGFloat = 22
    var weight: Font.Weight = .medium
    
    var body: some View {
        Image(systemName: systemName)
            .foregroundStyle(color)
            .font(.system(size: size, weight: weight))
    }
}
