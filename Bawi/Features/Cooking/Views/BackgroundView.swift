import SwiftUI


struct BackgroundView: View {
  var body: some View {
    Image("Group 1")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .opacity(0.3)
      .ignoresSafeArea()
      .clipped()
  }
}
