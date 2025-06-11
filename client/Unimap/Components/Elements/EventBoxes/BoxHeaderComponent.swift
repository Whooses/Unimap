import SwiftUI


struct BoxHeaderComponent: View {
    let pfp: PFPComponent
    let username: String
    
    var body: some View {
        HStack {
            pfp
            Text(username)
                .font(.headline)
                .bold()
                .foregroundColor(.black)
        }
    }
}
