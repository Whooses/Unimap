import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            Spacer()
            
            // Logo and Text
            VStack {
                Image("logo") // Replace with your logo image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330, height: 330)
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity)
                
                Text("Unimap")
                    .font(.custom("RobotoCondensed-Black", size: 60))
                    .foregroundColor(Color.blue)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
            
            // Buttons
            VStack(spacing: 20) {
                Button(action: {
                    // Login/Sign up action
                }) {
                    Text("Login/ Sign up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                
                Button(action: {
                    // Skip action
                }) {
                    Text("Skip")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
