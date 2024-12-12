import SwiftUI


struct FridgeContentView: View {
  @Binding var isPhoto: Bool
  @Binding var selectedImage: UIImage?
  @Binding var showImagePicker: Bool
  
  var body: some View {
    VStack {
      HeaderText(text: "Dans mon frigo \nil y a...")
      
      PhotoToggle(isPhoto: $isPhoto)
      
      if isPhoto {
        PhotoSelectionView(
          selectedImage: $selectedImage,
          showImagePicker: $showImagePicker
        )
      } else {
        ScrollView {
          FoodListView()
        }
      }
    }
  }
}
