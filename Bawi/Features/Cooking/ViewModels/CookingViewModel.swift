import SwiftUI

class CookingViewModel: ObservableObject {
  @Published var selectedFoods: [Ingredient] = sampleIngredients
  @Published var filters: Filters = Filters()
  @Published var selectedImage: UIImage? = nil
  
  func logData() {
    print("📝 Données enregistrées :")

    print("Quantité de personnes : \(filters.numberOfPeople)")

    
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
  
  func getPrompt() -> String {
    // Construction du contexte initial
    var prompt = "Je voudrais une recette de cuisine avec les ingrédients suivants :\n"
    
    // Ajout des ingrédients sélectionnés
    let ingredientsList = selectedFoods
      .filter { $0.quantity > 0 }
      .map { "- \($0.name) (\($0.quantity) \($0.quantity > 1 ? "unités" : "unité"))" }
      .joined(separator: "\n")
    
    prompt += ingredientsList
    
    // Ajout des contraintes et filtres
    prompt += "\n\nContraintes supplémentaires :"
    prompt += "\n- Pour \(filters.numberOfPeople) \(filters.numberOfPeople > 1 ? "personnes" : "personne")"
    
    if filters.isVegetarian {
      prompt += "\n- Recette végétarienne"
    }
    
    if filters.isGlutenFree {
      prompt += "\n- Sans gluten"
    }
    
    // Instructions spécifiques pour le format de réponse
    prompt += "\n\nMerci de me donner :"
    prompt += "\n1. Le nom de la recette"
    prompt += "\n2. Le temps de préparation"
    prompt += "\n3. La liste complète des ingrédients avec leurs quantités"
    prompt += "\n4. Les étapes de préparation numérotées"
    prompt += "\n5. Quelques conseils de préparation si nécessaire"
    
    prompt += "\n\n Commence directement à répondre en donnant la recette."
    
    return prompt
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
