import SwiftUI

// PhotoSelectionView.swift
struct PhotoSelectionView: View {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    var body: some View {
        Button(action: { showImagePicker = true }) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
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
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}
