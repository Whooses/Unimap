import SwiftUI

struct ExploreFilterLayout: View {
    @EnvironmentObject private var explorePageVM: ExplorePageVM
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .opacity(0.6)
                
                SSFilterBtn(
                    options: Sort.allCases,
                    selectedOption: explorePageVM.filter[explorePageVM.currTab]?.sort ?? .latest,
                    sheetTitle: "Select Sort"
                ) { newSelect in
                    explorePageVM.updateSort(newSelect)
                }
                
                MSFilterBtn(
                    label: "Clubs",
                    options: explorePageVM.schoolService.getSchoolClubs(schoolID: 1),
                    selectedOptions: explorePageVM.filter[explorePageVM.currTab]?.clubs ?? [],
                ) { newSelect in
                    explorePageVM.updateClubs(newSelect)
                }
                
                DRFilterBtn(
                    startDate: explorePageVM
                        .filter[explorePageVM.currTab]?
                        .startDate ?? nil,
                    endDate: explorePageVM
                        .filter[explorePageVM.currTab]?
                        .endDate ?? nil
                ) { from, to in
                    explorePageVM.updateDR(from, to)
                }
                
                Spacer()
            }
            .padding(.leading)
        }
    }
}


//#Preview {
//    ExploreFilterLayout()
//}

