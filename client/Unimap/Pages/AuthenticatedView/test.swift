import SwiftUI

struct MyItem: Identifiable {
    let id = UUID()
    let title: String
}

struct MyCustomView: View {
    let item: MyItem

    var body: some View {
        Text(item.title)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)
            .onAppear() {
//                print("Appeared: \(item.title)")
            }
    }
}

struct ScrollToTopExample: View {
    @State private var items = (1...500).map { MyItem(title: "Item \($0)") }
    @State private var scrollTarget: UUID? = nil

    var body: some View {
        VStack {
            Button("Scroll to Top") {
                withAnimation {
                    print("Scrolling top!")
                    scrollTarget = items.first?.id
                }
            }
            .padding()

            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(items) { item in
                        MyCustomView(item: item)
                            .id(item.id)  // ✅ Attach ID here
                    }
                }
            }
            .scrollTargetLayout()
            .scrollPosition(id: $scrollTarget, anchor: .top)
        }
    }
}

#Preview {
    ScrollToTopExample()
}
