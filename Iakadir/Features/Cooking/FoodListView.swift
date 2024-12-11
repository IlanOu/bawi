import SwiftUI

struct FoodListView: View {
  
  @EnvironmentObject var cookingViewModel: CookingViewModel
  @StateObject private var viewModel = FoodListViewModel()
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
        ForEach($cookingViewModel.selectedFoods) { $ingredient in
          IngredientCard(
            ingredient: $ingredient,
            onIncrement: {
              cookingViewModel.incrementQuantity(of: ingredient)
            },
            onDecrement: {
              cookingViewModel.decrementQuantity(of: ingredient)
            }
          )
        }
      }
      .padding()
    }
  }
}

#Preview {
  HomeView()
}
