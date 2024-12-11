import Combine
import Foundation

class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var isLoading = false
  @Published var error: String?
  
  private let authService: AuthenticationServiceProtocol
  private var cancellables = Set<AnyCancellable>()
  
  init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
    self.authService = authService
  }
  
  func login() {
    isLoading = true
    error = nil
    
    authService.login(email: email, password: password)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        self?.isLoading = false
        if case .failure(let error) = completion {
          self?.error = error.localizedDescription
        }
      } receiveValue: { user in
        print("Logged in user: \(user)")
        // TODO: Handle successful login (e.g., navigate to main app screen)
      }
      .store(in: &cancellables)
  }
}

