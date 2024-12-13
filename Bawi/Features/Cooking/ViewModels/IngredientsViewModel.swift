import Foundation

struct Ingredient: Identifiable, Equatable {
  let id = UUID()
  let name: String
  var quantity: Int
  let image: String
}


let sampleIngredients: [Ingredient] = [
    Ingredient(name: "Tranche de jambon", quantity: 0, image: "ham"),
    Ingredient(name: "Pomme de terre", quantity: 0, image: "potato"),
    Ingredient(name: "Carotte", quantity: 0, image: "carrot"),
    Ingredient(name: "Banane", quantity: 0, image: "banana"),
    Ingredient(name: "Pomme", quantity: 0, image: "apple"),
    Ingredient(name: "Kiwi", quantity: 0, image: "kiwi"),
    Ingredient(name: "Emmental", quantity: 0, image: "cheese"),
    Ingredient(name: "Tomate", quantity: 0, image: "tomato"),
    Ingredient(name: "Courgette", quantity: 0, image: "zucchini"),
    Ingredient(name: "Œuf", quantity: 0, image: "egg"),
    Ingredient(name: "Citron", quantity: 0, image: "lemon"),
    Ingredient(name: "Salade", quantity: 0, image: "lettuce"),
    Ingredient(name: "Oignon", quantity: 0, image: "onion"),
    Ingredient(name: "Brocoli", quantity: 0, image: "broccoli"),
    Ingredient(name: "Poivron", quantity: 0, image: "bell_pepper"),
    Ingredient(name: "Riz", quantity: 0, image: "rice"),
    Ingredient(name: "Poulet", quantity: 0, image: "chicken"),
    Ingredient(name: "Saumon", quantity: 0, image: "salmon"),
    Ingredient(name: "Pain", quantity: 0, image: "bread"),
    Ingredient(name: "Champignon", quantity: 0, image: "mushroom"),
    Ingredient(name: "Lait", quantity: 0, image: "milk"),
    Ingredient(name: "Beurre", quantity: 0, image: "butter"),
    Ingredient(name: "Crème fraîche", quantity: 0, image: "cream"),
    Ingredient(name: "Chocolat", quantity: 0, image: "chocolate"),
    Ingredient(name: "Fraise", quantity: 0, image: "strawberry"),
    Ingredient(name: "Ananas", quantity: 0, image: "pineapple"),
    Ingredient(name: "Orange", quantity: 0, image: "orange"),
    Ingredient(name: "Abricot", quantity: 0, image: "apricot"),
    Ingredient(name: "Ail", quantity: 0, image: "garlic"),
    Ingredient(name: "Persil", quantity: 0, image: "parsley"),
    Ingredient(name: "Basilic", quantity: 0, image: "basil"),
    Ingredient(name: "Menthe", quantity: 0, image: "mint"),
    Ingredient(name: "Farine", quantity: 0, image: "flour"),
    Ingredient(name: "Sucre", quantity: 0, image: "sugar"),
    Ingredient(name: "Sel", quantity: 0, image: "salt"),
    Ingredient(name: "Poivre", quantity: 0, image: "pepper"),
    Ingredient(name: "Miel", quantity: 0, image: "honey"),
    Ingredient(name: "Yaourt", quantity: 0, image: "yogurt"),
    Ingredient(name: "Huile d'olive", quantity: 0, image: "olive_oil"),
    Ingredient(name: "Vinaigre", quantity: 0, image: "vinegar"),
    Ingredient(name: "Steak haché", quantity: 0, image: "ground_beef"),
    Ingredient(name: "Crevette", quantity: 0, image: "shrimp"),
    Ingredient(name: "Thon", quantity: 0, image: "tuna"),
    Ingredient(name: "Courge", quantity: 0, image: "squash"),
    Ingredient(name: "Patate douce", quantity: 0, image: "sweet_potato"),
    Ingredient(name: "Poireau", quantity: 0, image: "leek"),
    Ingredient(name: "Radis", quantity: 0, image: "radish"),
    Ingredient(name: "Ciboulette", quantity: 0, image: "chives"),
    Ingredient(name: "Gingembre", quantity: 0, image: "ginger"),
    Ingredient(name: "Cannelle", quantity: 0, image: "cinnamon")
]
