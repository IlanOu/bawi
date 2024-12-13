import SwiftUI

struct CookingView: View {
  @EnvironmentObject var cookingViewModel: CookingViewModel
  @State private var selectedTab: Int = 0
  @State private var selectedImage: UIImage? = nil
  @State private var showImagePicker: Bool = false
  @State private var isLoading: Bool = false
  @State private var isPhoto = false
  
  var body: some View {
    ZStack {
      BackgroundView()
      
      VStack {
        if selectedTab == 0 {
          FridgeContentView()
        } else {
          FilterContentView(
            isLoading: $isLoading,
            cookingViewModel: cookingViewModel
          )
        }
        
        Spacer()
        
        TabBarView(selectedTab: $selectedTab)
      }
      .padding()
      .foregroundStyle(.white)
    }
    .background(Color("primary"))
  }
}
