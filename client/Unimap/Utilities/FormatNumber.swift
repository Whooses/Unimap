//
//  FormatNumber.swift
//  Unimap
//
//  Created by Krisha Patel on 2025-05-12.
//

func formatNumber(_ number: Int) -> String {
    //Formats the number to display following counts, #of events, etc.
    if number < 1000 {
        return "\(number)"
    } else {
        let truncated = Double(number) / 1000.0
        let rounded = (truncated * 10).rounded() / 10  // 1 decimal point
        return "\(rounded)k"
    }
}
