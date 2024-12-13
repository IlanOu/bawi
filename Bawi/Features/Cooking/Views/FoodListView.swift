import SwiftUI

struct FoodListView: View {
    @EnvironmentObject var cookingViewModel: CookingViewModel
    @State private var searchText: String = "" // Propriété pour le texte de recherche

    var body: some View {
        VStack {
            // Barre de recherche stylée
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("secondary"))
                TextField("Rechercher un aliment...", text: $searchText)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(0.15))
            .cornerRadius(12)
            .padding(.horizontal)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                    // Filtrer les ingrédients en fonction du texte de recherche
                    ForEach(filteredIngredients, id: \.id) { ingredient in
                        IngredientView(
                            ingredient: Binding(
                                get: { ingredient },
                                set: { updatedIngredient in
                                    if let index = cookingViewModel.selectedFoods.firstIndex(where: { $0.id == updatedIngredient.id }) {
                                        cookingViewModel.selectedFoods[index] = updatedIngredient
                                    }
                                }
                            ),
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

    // Propriété calculée pour filtrer les ingrédients
    private var filteredIngredients: [Ingredient] {
        if searchText.isEmpty {
            return cookingViewModel.selectedFoods
        } else {
            return cookingViewModel.selectedFoods.filter { ingredient in
                ingredient.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    HomeView()
}
