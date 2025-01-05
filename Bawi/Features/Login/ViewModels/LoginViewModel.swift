import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var error: String?
    @Published var isLoginSuccessful = false
    
    @EnvironmentObject var authState: AuthState
    
    func attemptLogin() async {
        guard !isLoading else { return }
        
        isLoading = true
        error = nil
        
        do {
            try await authState.login(email: email, password: password)
            isLoginSuccessful = true
        } catch {
            self.error = error.localizedDescription
            isLoginSuccessful = false
        }
        
        isLoading = false
    }
}
