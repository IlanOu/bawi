import SwiftUI

// CookingButton.swift
struct CookingButton: View {
    @Binding var isLoading: Bool
    var cookingViewModel: CookingViewModel
    
    var body: some View {
        Button(action: {
            sendRequestToAPI()
            cookingViewModel.logData()
        }) {
            if isLoading {
                CustomButton(title: "Attends, ça charge...")
            } else {
                CustomButton(title: "Cuisinons !")
            }
        }
        .disabled(isLoading)
    }
    
    private func sendRequestToAPI() {
      isLoading = true
      print("send to api ")
      
      print(cookingViewModel.getPrompt())
      print()
      
        // Logique d'appel à l'API ici...
    }
}
