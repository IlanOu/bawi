import SwiftUI

class CookingViewModel: ObservableObject {
    @Published var selectedFoods: [Ingredient] = sampleIngredients
    @Published var filters: Filters = Filters()
    
    @Published var selectedImage: UIImage? = nil
    @Published var isPhoto: Bool = false
    @Published var showImagePicker: Bool = false

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
        // Si une image est sélectionnée
        if let _ = selectedImage {
            var prompt = """
            J'ai une image d'ingrédients. Merci de me donner les informations suivantes dans cet ordre :
            1. Le nom de la recette (sans markdown ou formatage, uniquement le titre brut, uniquement pour ce point, la suite peut être en markdown)
            2. Les ingrédients que tu vois dans une liste (avec les quantités, en précisant que certains peuvent ne pas être utilisés)
            3. Le temps de préparation
            4. La liste complète des ingrédients nécessaires avec leurs quantités (parmi les ingrédients visibles ou d'autres que tu peux suggérer)
            5. Les étapes de préparation numérotées
            6. Quelques conseils de préparation si nécessaire
            """

            // Ajout des contraintes
            prompt += "\n\nContraintes supplémentaires :"
            prompt += "\n- Pour \(filters.numberOfPeople) \(filters.numberOfPeople > 1 ? "personnes" : "personne")"
            if filters.isVegetarian {
                prompt += "\n- Recette végétarienne"
            }
            if filters.isGlutenFree {
                prompt += "\n- Sans gluten"
            }
            if !filters.haveFurnace {
                prompt += "\n- Sans utiliser de four"
            }

            // Instructions finales
            prompt += "\n\nCommence directement à répondre en donnant les informations demandées. Pas besoin de formule de politesse. La première ligne de la réponse doit contenir uniquement le nom de la recette, sans aucun formatage. Pour le reste du texte, utilises le formatage en markdown (titres, graisses, italique, etc.). Note également que tous les ingrédients visibles ne doivent pas forcément être utilisés dans la recette."
            return prompt
        }

        // Construction du contexte initial si pas d'image
        var prompt = "Je voudrais une recette de cuisine avec les ingrédients suivants (ils ne sont pas tous obligatoires dans la recette) :\n"
        
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
        if !filters.haveFurnace {
            prompt += "\n- Sans utiliser de four"
        }
        
        // Instructions spécifiques pour le format de réponse
        prompt += "\n\nMerci de me donner les informations suivantes dans cet ordre :"
        prompt += "\n1. Le nom de la recette (sans markdown ou formatage, uniquement le titre brut, uniquement pour ce point, la suite peut être en markdown)"
        prompt += "\n2. Le temps de préparation"
        prompt += "\n3. La liste complète des ingrédients nécessaires avec leurs quantités (en précisant que tous les ingrédients listés ne sont pas forcément utilisés)"
        prompt += "\n4. Les étapes de préparation numérotées"
        prompt += "\n5. Quelques conseils de préparation si nécessaire"
        
        prompt += "\n\nCommence directement à répondre en donnant les informations demandées. Pas besoin de formule de politesse. La première ligne de la réponse doit contenir uniquement le nom de la recette, sans aucun formatage. Pour le reste du texte, utilises le formatage en markdown (titres, graisses, italique, etc.). Note également que tous les ingrédients visibles ne doivent pas forcément être utilisés dans la recette."
        
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
