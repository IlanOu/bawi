import SwiftUI

struct CookingView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var selectedFoods: [String] = []
    @State private var filters: Filters = Filters()
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            // Section 1: Photo ou sélection d'aliments
            Section(header: Text("Aliments").font(.headline)) {
                HStack {
                    Button(action: { showImagePicker = true }) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        } else {
                            Image(systemName: "camera")
                                .font(.title)
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Sélectionner des aliments :")
                            .font(.subheadline)
                        FoodListView(selectedFoods: $selectedFoods)
                    }
                }
            }
            .padding()

            // Section 2: Filtres
            Section(header: Text("Filtres").font(.headline)) {
                FilterView(filters: $filters)
            }
            .padding()

            // Section 3: Bouton de validation
            Button(action: { sendRequestToAPI() }) {
                HStack {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Trouver des recettes")
                            .fontWeight(.bold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .disabled(isLoading)
        }
        .navigationTitle("Préparer un plat")
    }

    private func sendRequestToAPI() {
        isLoading = true
        // Logique d'appel à l'API ici...
    }
}

// Exemple de modèle pour les filtres
struct Filters {
    var numberOfPeople: Int = 1
    var isVegetarian: Bool = false
    var isGlutenFree: Bool = false
}

#Preview {
    CookingView()
}
