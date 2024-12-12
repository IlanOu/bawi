import SwiftUI


struct TabBarView: View {
  @Binding var selectedTab: Int
  
  var body: some View {
    HStack {
      TabButton(
        title: "Aliments",
        isSelected: selectedTab == 0,
        action: { selectedTab = 0 }
      )
      
      TabButton(
        title: "Filtres",
        isSelected: selectedTab == 1,
        action: { selectedTab = 1 }
      )
    }
    .background(Color.white)
    .cornerRadius(16)
    .shadow(radius: 5)
  }
}
