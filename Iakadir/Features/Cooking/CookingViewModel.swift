import SwiftUI

class CookingViewModel: ObservableObject {
  @Published var selectedFoods: [Ingredient] = sampleIngredients
  @Published var filters: Filters = Filters()
  @Published var selectedImage: UIImage? = nil
  
  func logData() {
    print("📝 Données enregistrées :")
    
    print("  - Aliments sélectionnés :")
    for ingredient in selectedFoods {
      print("    • \(ingredient.name): Quantité: \(ingredient.quantity), Autres données: \(ingredient.image)")
    }
    
    print("  - Allergies (Végétarien) : \(filters.isVegetarian)")
    print("  - Allergies (Sans gluten) : \(filters.isGlutenFree)")
    
    if let _ = selectedImage {
      print("  - Une image a été sélectionnée.")
    } else {
      print("  - Pas d'image sélectionnée.")
    }
  }
  
  func incrementQuantity(of ingredient: Ingredient) {
    if let index = selectedFoods.firstIndex(where: { $0.id == ingredient.id }) {
      selectedFoods[index].quantity += 1
    }
  }
  
  func decrementQuantity(of ingredient: Ingredient) {
    if let index = selectedFoods.firstIndex(where: { $0.id == ingredient.id }) {
      if selectedFoods[index].quantity > 0 {
        selectedFoods[index].quantity -= 1
      }
    }
  }
}

/*
struct FoodDetails {
  var quantity: Int
  var additionalInfo: [String: Any] = [:] // Permet d'ajouter des données supplémentaires
}
*/
