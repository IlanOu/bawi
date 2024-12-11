import Combine
import Foundation


class SignupViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var username = ""
  @Published var isLoading = false
  @Published var error: String?
  
  private let authService: AuthenticationServiceProtocol
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func signup() async {
    guard password == confirmPassword else {
      error = "Passwords do not match"
      return
    }
    
    do {
      let user = try await authService.signup(email: email, password: password)
    } catch {
      print("error sign up")
    }
    
    isLoading = false
    
  }
}
