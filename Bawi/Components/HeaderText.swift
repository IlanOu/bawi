import SwiftUI


struct HeaderText: View {
  let text: String
  
  var body: some View {
    Text(text)
      .font(.largeTitle)
      .fontWeight(.black)
      .multilineTextAlignment(.center)
  }
}
