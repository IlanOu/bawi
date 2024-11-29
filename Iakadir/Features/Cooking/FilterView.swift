import SwiftUI

struct FilterView: View {
    @Binding var filters: Filters

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack(spacing: 10) {
                
                
                Text("\(filters.numberOfPeople)")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text("personnes")
                
                Spacer()
                
                HStack(spacing: 8) {
                    
                    Button(action: { if filters.numberOfPeople > 0 { filters.numberOfPeople -= 1 } }) {
                        Image(systemName: "minus")
                            .frame(width: 32, height: 32)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button(action: { if filters.numberOfPeople < 10 {filters.numberOfPeople += 1} }) {
                        Image(systemName: "plus")
                            .frame(width: 32, height: 32)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            
            Toggle("Végétarien ?", isOn: $filters.isVegetarian)
            Toggle("Sans gluten ?", isOn: $filters.isGlutenFree)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    CookingView()
}
