import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var error: String?
  @Published var isLoginSuccessful = false
  @Published var token: String = ""
  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func attemptLogin() async {
    guard !isLoading else { return }
    
    isLoading = true
    error = nil
    
    do {
      let (user, token) = try await authService.login(email: email, password: password)
      isLoginSuccessful = true
    } catch {
      self.error = error.localizedDescription
      isLoginSuccessful = false
    }
    
    isLoading = false
  }
}
