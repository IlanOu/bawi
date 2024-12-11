import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var error: String?
  @Published var isLoginSuccessful = false  // Nouvelle variable pour l'état de la connexion réussie
  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func login() {
    Task {
      isLoading = true
      error = nil
      isLoginSuccessful = false  // Réinitialiser l'état de la connexion réussie à chaque tentative
      
      do {
        let user = try await authService.login(email: email, password: password)
        print("Logged in user: \(user)")
        // Si la connexion est réussie, on met à jour l'état
        isLoginSuccessful = true
      } catch {
        self.error = error.localizedDescription
      }
      
      isLoading = false
    }
  }
}
