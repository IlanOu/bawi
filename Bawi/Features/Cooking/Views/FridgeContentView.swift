import SwiftUI


struct FridgeContentView: View {
    @EnvironmentObject var cookingViewModel: CookingViewModel
  
    var body: some View {
        VStack {
            HeaderText(text: "Dans mon frigo \nil y a...")
          
            PhotoToggle(isPhoto: $cookingViewModel.isPhoto)

            if cookingViewModel.isPhoto {
                PhotoSelectionView()
            } else {
                ScrollView {
                    FoodListView()
                }
            }
        }
    }
}
