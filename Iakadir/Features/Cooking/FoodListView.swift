import SwiftUI

struct Ingredient: Identifiable, Equatable {
    let id = UUID()
    let name: String
    var quantity: Int
    let image: String
}

struct FoodListView: View {
    @Binding var selectedFoods: [String]
    @State private var ingredients = [
        Ingredient(name: "Tranche de jambon", quantity: 0, image: "ham"),
        Ingredient(name: "Pomme de terre", quantity: 0, image: "potatoes"),
        Ingredient(name: "Carotte", quantity: 0, image: "carrots")
    ]
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach($ingredients) { $ingredient in
                IngredientCard(ingredient: $ingredient)
            }
        }
        .onAppear() {
            updateSelectedFoods()
        }
        .onChange(of: ingredients) { _, _ in
            updateSelectedFoods()
        }
    }
    
    private func updateSelectedFoods() {
        selectedFoods = ingredients.filter { $0.quantity > 0 }.map { $0.name }
    }
}

struct IngredientCard: View {
    @Binding var ingredient: Ingredient
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Spacer()
                
                Text(ingredient.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 10) {
                    Text("Quantité :")
                    
                    Text("\(ingredient.quantity)")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 8) {
                        Button(action: { if ingredient.quantity > 0 { ingredient.quantity -= 1 } }) {
                            Image(systemName: "minus")
                                .frame(width: 32, height: 32)
                                .background(Color.gray.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        
                        Button(action: { ingredient.quantity += 1 }) {
                            Image(systemName: "plus")
                                .frame(width: 32, height: 32)
                                .background(Color.gray.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
                .padding(.leading, 10)
                Spacer()
            }
            
            Spacer()
            
            Image(ingredient.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipped()
                .frame(width: 100, height: 100)

        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("item"), Color.white.opacity(0)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(24)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .foregroundStyle(Color("text"))
    }
        
}

#Preview {
    CookingView()
}
