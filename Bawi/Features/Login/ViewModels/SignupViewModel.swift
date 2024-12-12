import Combine
import Foundation


class SignupViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var username = ""
  @Published var isLoading = false
  @Published var error: String?
  @Published var isSignupSuccessful: Bool = false

  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func signup() async {
    guard password == confirmPassword else {
      error = "Passwords do not match"
      isLoading = false
      return
    }
    
    isLoading = true
    
    do {
      try await authService.signup(email: email, password: password)
      isSignupSuccessful = true
      // Mettre à jour l'état pour indiquer que l'inscription a réussi
      isLoading = false
    } catch {
      self.error = error.localizedDescription
      isLoading = false
    }
  }

}
