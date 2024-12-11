import Foundation

struct Ingredient: Identifiable, Equatable {
  let id = UUID()
  let name: String
  var quantity: Int
  let image: String
}

let sampleIngredients: [Ingredient] = [
  Ingredient(name: "Tranche de jambon", quantity: 0, image: "ham"),
  Ingredient(name: "Pomme de terre", quantity: 0, image: "potatoes"),
  Ingredient(name: "Carotte", quantity: 0, image: "carrots")
]
