import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var error: String?
  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func login() {
    Task {
      isLoading = true
      error = nil
      
      do {
        let user = try await authService.login(email: email, password: password)
        print("Logged in user: \(user)")
        // TODO: Handle successful login (e.g., navigate to main app screen)
      } catch {
        self.error = error.localizedDescription
      }
      
      isLoading = false
    }
  }
}

