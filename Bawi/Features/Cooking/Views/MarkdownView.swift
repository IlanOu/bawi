import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    var content: String
    var ingredients: [Ingredient]
    @Binding var isLoading: Bool

    var body: some View {
        ZStack {
            // Background color
            Color("primary")
                .ignoresSafeArea()
            
            
            ScrollView {
                if isLoading {
                    ProgressView("Création d'une recette en cours...")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("text"))
                        .multilineTextAlignment(.center)
                } else {
                    VStack(spacing: 12) {
                        if !ingredients.isEmpty {
                            Text("Vos ingrédients:")
                                .font(.title)
                                .foregroundColor(Color("text"))
                                .padding(.vertical)
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
                                /*
                                 Text("- \(ingredient.name) (\(ingredient.quantity))")
                                 .padding(.horizontal)
                                 */
                                ForEach(ingredients, id: \.id) { ingredient in
                                    if (ingredient.quantity > 0){
                                        SimpleIngredientView(ingredient: ingredient)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        Spacer()
                        
                        Text("La recette:")
                            .font(.title)
                            .foregroundColor(Color("text"))
                            .padding(.vertical)
                        
                        // Affichage du markdown
                        Markdown(content)
                            .markdownTheme(.custom)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(12)
                            .padding()
                        
                    }
                }
            }
        }
        
    }
}

extension Theme {
    static let custom = Theme()
        .text {
            ForegroundColor(Color("text"))
        }
}
