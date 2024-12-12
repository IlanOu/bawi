import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var error: String?
  @Published var isLoginSuccessful = false
  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func attemptLogin() async {
    guard !isLoading else { return }  // Évite les tentatives multiples
    
    isLoading = true
    error = nil
    
    do {
      let user = try await authService.login(email: email, password: password)
      print("Logged in user: \(user)")
      isLoginSuccessful = true
    } catch {
      self.error = error.localizedDescription
      isLoginSuccessful = false
    }
    
    isLoading = false
  }
}
