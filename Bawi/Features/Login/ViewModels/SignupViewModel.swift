import Combine
import SwiftUI
import Foundation

class SignupViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var username = ""
    @Published var isLoading = false
    @Published var error: String?
    @Published var isSignupSuccessful: Bool = false
    @Published var authState: AuthState
    
    init(authState: AuthState) {
        self.authState = authState
    }
    
    func signup() async {
        guard password == confirmPassword else {
            // Assurez-vous que ces mises à jour se font sur le thread principal
            DispatchQueue.main.async {
                self.error = "Passwords do not match"
                self.isLoading = false
            }
            return
        }
        
        // Assurez-vous que ces mises à jour se font sur le thread principal
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        do {
            try await authState.signup(email: email, password: password)
            // Assurez-vous que ces mises à jour se font sur le thread principal
            DispatchQueue.main.async {
                self.isSignupSuccessful = true
                self.isLoading = false
            }
        } catch {
            // Assurez-vous que ces mises à jour se font sur le thread principal
            DispatchQueue.main.async {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
