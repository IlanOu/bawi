import SwiftUI


struct TabButton: View {
  let title: String
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .foregroundColor(isSelected ? .blue : .gray)
    }
    .padding()
  }
}
