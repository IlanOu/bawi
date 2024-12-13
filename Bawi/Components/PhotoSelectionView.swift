import SwiftUI

struct PhotoSelectionView: View {
    @EnvironmentObject var cookingViewModel: CookingViewModel
    
    var body: some View {
        Button(action: { cookingViewModel.showImagePicker = true }) {
            if let image = cookingViewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(8)
            } else {
                VStack {
                    Spacer()
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .font(.title)
                        .foregroundColor(Color("secondary"))
                        .frame(width: 100, height: 100)
                    
                    Text("Sélectionner une image")
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $cookingViewModel.showImagePicker) {
            ImagePicker(selectedImage: $cookingViewModel.selectedImage)
        }
    }
}
