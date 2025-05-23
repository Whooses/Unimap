import SwiftUI

struct NewSearchBarComponent: View {
    @Binding var searchText: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack() {
            
            // Search Bar
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                TextField("Search", text: $searchText)
                    .focused($isTextFieldFocused)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .regular))
                    .onSubmit {
                        isTextFieldFocused = false
                    }

                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .offset(x: -20)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

struct searchingView: View {
    
    var body: some View {
        VStack {
            Text("Searching...")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 12)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}






//private struct ContentView: View {
//    @State var searchText: String = ""
//    var body: some View {
//        NewSearchBarComponent(searchText: $searchText)
//    }
//}
//
//#Preview {
//    ContentView()
//}
