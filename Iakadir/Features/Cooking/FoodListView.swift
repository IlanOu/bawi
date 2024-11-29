import SwiftUI

struct FoodListView: View {
    @Binding var selectedFoods: [String]
    let foods = ["Tomate", "Pomme", "Poulet", "Carotte", "Fromage"]

    var body: some View {
        List(foods, id: \.self) { food in
            MultipleSelectionRow(title: food, isSelected: selectedFoods.contains(food)) {
                if selectedFoods.contains(food) {
                    selectedFoods.removeAll { $0 == food }
                } else {
                    selectedFoods.append(food)
                }
            }
        }
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .onTapGesture { action() }
        .background()
    }
}

#Preview {
    CookingView()
}
