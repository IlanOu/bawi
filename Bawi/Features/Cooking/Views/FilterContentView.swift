import SwiftUI


struct FilterContentView: View {
  @Binding var isLoading: Bool
  var cookingViewModel: CookingViewModel
  
  var body: some View {
    VStack {
      HeaderText(text: "Je vais faire \nà manger pour...")
      
      Spacer()
      
      FilterView()
      
      Spacer()
      
      CookingButton(
        isLoading: $isLoading,
        cookingViewModel: cookingViewModel
      )
    }
  }
}
