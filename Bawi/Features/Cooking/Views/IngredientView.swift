import SwiftUI

struct IngredientView: View {
  @Binding var ingredient: Ingredient
  var onIncrement: () -> Void
  var onDecrement: () -> Void
  
  var body: some View {
    VStack(spacing: 12) {
      // Image de l'ingrédient
      Image(ingredient.image)
        .resizable()
        .scaledToFit()
        .frame(height: 100)
        .clipShape(Circle())
        .overlay(
          Circle()
            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
        )
      
      // Nom de l'ingrédient
      Text(ingredient.name)
        .font(.headline)
        .foregroundColor(.primary)
        .lineLimit(1)
        .truncationMode(.tail)
      
      // Contrôles de quantité
      HStack(spacing: 12) {
        Button(action: onDecrement) {
          Image(systemName: "minus")
            .frame(width: 36, height: 36)
            .background(Color.red.opacity(0.2))
            .clipShape(Circle())
            .foregroundColor(.red)
        }
        
        Text("\(ingredient.quantity)")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundColor(.primary)
        
        Button(action: onIncrement) {
          Image(systemName: "plus")
            .frame(width: 36, height: 36)
            .background(Color.green.opacity(0.2))
            .clipShape(Circle())
            .foregroundColor(.green)
        }
      }
    }
    .padding()
    .frame(maxWidth: 150) // Taille maximum pour garder une grille propre
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(
          LinearGradient(
            gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
            startPoint: .top,
            endPoint: .bottom
          )
        )
    )
    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
  }
}
