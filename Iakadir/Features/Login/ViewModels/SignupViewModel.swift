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
  private var cancellables = Set<AnyCancellable>()
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func signup() {
    guard password == confirmPassword else {
      error = "Passwords do not match"
      return
    }
    
    isLoading = true
    error = nil
    
    authService.signup(email: email, password: password, username: username)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        if case .failure(let error) = completion {
          self?.error = error.localizedDescription
        }
      } receiveValue: { user in
        print("Signed up user: \(user)")
        // TODO: Handle successful signup (e.g., navigate to main app screen or login screen)
      }
      .store(in: &cancellables)
  }
}
