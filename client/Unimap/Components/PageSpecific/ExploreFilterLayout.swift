import SwiftUI

struct ExploreFilterLayout: View {
    @ObservedObject var builder: EventRequestBuilder

    var body: some View {
        HStack {
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

