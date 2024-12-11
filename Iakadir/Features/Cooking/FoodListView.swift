import SwiftUI

struct FoodListView: View {
  
  @EnvironmentObject var cookingViewModel: CookingViewModel
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
        ForEach($cookingViewModel.selectedFoods) { $ingredient in
          IngredientView(
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
