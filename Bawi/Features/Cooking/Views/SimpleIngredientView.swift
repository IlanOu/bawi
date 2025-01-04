//
//  IngredientView 2.swift
//  Bawi
//
//  Created by Ilan Outhier on 04/01/2025.
//


import SwiftUI

struct SimpleIngredientView: View {
    var ingredient: Ingredient

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
            
            Text("x\(String(ingredient.quantity))")
                .font(.headline)
                .foregroundColor(Color("text"))
                .lineLimit(1)
                .truncationMode(.tail)

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
