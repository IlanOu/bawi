import SwiftUI


struct PhotoToggle: View {
  @Binding var isPhoto: Bool
  
  var body: some View {
    Toggle("Je veux prendre une photo !", isOn: $isPhoto)
      .padding(.vertical, 20)
      .font(.headline)
      .fontWeight(.bold)
  }
}
