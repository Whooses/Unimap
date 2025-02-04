//
//  UnauthenticatedView.swift
//  Unimap
//
//  Created by Bhavya Patel on 2025-01-22.
//

import SwiftUI

struct UnauthenticatedView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 330)
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity)
                
                Text("Unimap")
                    .font(.custom("RobotoCondensed-Black", size: 60))
                    .foregroundColor(Color(hex: "#083162"))
                    .padding(.top, -50)
                    .kerning(7)
            }
            
            Spacer()
            
            VStack(spacing: 20) {
                Button(action: {
                    authViewModel.login()
                }) {
                    Text("Login/ Sign up")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 261, height: 44)
                        .background(Color(hex: "#083162"))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Skip action
                }) {
                    Text("Skip")
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
