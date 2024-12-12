import SwiftUI

struct FilterView: View {
  @EnvironmentObject var cookingViewModel: CookingViewModel
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // Sélection du nombre de personnes
      HStack(spacing: 10) {
        Text("\(cookingViewModel.filters.numberOfPeople)")
          .font(.title3)
          .fontWeight(.medium)
        
        Text("personnes")
        
        Spacer()
        
        HStack(spacing: 8) {
          // Bouton pour diminuer le nombre de personnes
          Button(action: {
            if cookingViewModel.filters.numberOfPeople > 0 {
              cookingViewModel.filters.numberOfPeople -= 1
            }
          }) {
            Image(systemName: "minus")
              .frame(width: 32, height: 32)
              .background(Color.gray.opacity(0.3))
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
          
          // Bouton pour augmenter le nombre de personnes
          Button(action: {
            if cookingViewModel.filters.numberOfPeople < 10 {
              cookingViewModel.filters.numberOfPeople += 1
            }
          }) {
            Image(systemName: "plus")
              .frame(width: 32, height: 32)
              .background(Color.gray.opacity(0.3))
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
        }
      }
      
      // Options de filtres
      Toggle("Végétarien ?", isOn: $cookingViewModel.filters.isVegetarian)
      Toggle("Sans gluten ?", isOn: $cookingViewModel.filters.isGlutenFree)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
    .cornerRadius(8)
  }
}

#Preview {
  FilterView()
    .environmentObject(CookingViewModel())
}
