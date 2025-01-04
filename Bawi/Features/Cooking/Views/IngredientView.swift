import SwiftUI

struct IngredientView: View {
    @Binding var ingredient: Ingredient
    var onIncrement: () -> Void
    var onDecrement: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            // Vérification de la validité de l'image
            if let image = UIImage(named: ingredient.image) {
                // Affichage de l'image uniquement si elle est valide
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            }

            // Nom de l'ingrédient
            Text(ingredient.name)
                .font(.headline)
                .foregroundColor(Color("text"))
                .lineLimit(1)
                .truncationMode(.tail)

            // Contrôles de quantité
            HStack(spacing: 16) {
                Button(action: onDecrement) {
                    Image(systemName: "minus")
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Circle())
                        .foregroundColor(.red)
                }

                Text("\(ingredient.quantity)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("text"))

                Button(action: onIncrement) {
                    Image(systemName: "plus")
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Circle())
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .frame(maxWidth: 150)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.1))
        )
        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
    }
}
