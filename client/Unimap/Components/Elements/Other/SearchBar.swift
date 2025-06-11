import SwiftUI

struct SearchBarComponent: View {
    let onSubmit: ((String)->Void)?
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var tempSearchText: String = ""
    
    var body: some View {
        VStack() {
            
            // Search Bar
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                TextField("Search", text: $tempSearchText)
                    .focused($isTextFieldFocused)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .regular))
                    .onSubmit {
                        onSubmit?(tempSearchText)
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
//        SearchBarComponent(searchText: $searchText)
//    }
//}
//
//#Preview {
//    ContentView()
//}
