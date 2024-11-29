import SwiftUI

struct FilterView: View {
    @Binding var filters: Filters

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Stepper("Nombre de personnes : \(filters.numberOfPeople)", value: $filters.numberOfPeople, in: 1...10)
            Toggle("Végétarien", isOn: $filters.isVegetarian)
            Toggle("Sans gluten", isOn: $filters.isGlutenFree)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
