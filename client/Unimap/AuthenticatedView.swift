//
//  AuthenticatedView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct AuthenticatedView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavBarComponent()
    }
}
