import SwiftUI

struct ExploreFilterLayout: View {
    @ObservedObject var builder: EventRequestBuilder

    var body: some View {
        HStack {
            Image(systemName: "line.3.horizontal.decrease")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .opacity(0.6)

            SSFilterBtn(
                label: "Latest",
                options: [
                    "Latest",
                    "Upcoming",
                    "Recently added",
                    "Past"
                ],
                builder: builder
            )

            MSFilterBtn(
                label: "Clubs",
                options: [
                    "amacss",
                    "csec",
                    "mathematics club",
                    "programming club"
                ],
                builder: builder
            )

            DRFilterBtn(builder: builder)

            Spacer()
        }
        .padding(.leading, 25)
    }
}


//#Preview {
//    FilterbarLayout()
//}

