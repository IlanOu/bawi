import Foundation
import Combine

@MainActor
class AuthState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User? = nil
    
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authService = authService
        
        Task {
            // Vérifie si l'utilisateur est déjà connecté au démarrage de l'application
            self.isLoggedIn = await isAuthenticated()
        }
    }
    
    func login(email: String, password: String) async throws {
        do {
            let (user, _) = try await authService.login(email: email, password: password)
            self.currentUser = user
            self.isLoggedIn = true
        } catch {
            print("Erreur lors de la connexion : \(error.localizedDescription)")
            throw error
        }
    }
    
    func signup(email: String, password: String) async throws {
        do {
            let (user, _) = try await authService.signup(email: email, password: password)
            self.currentUser = user
            self.isLoggedIn = true
        } catch {
            print("Erreur lors de l'inscription : \(error.localizedDescription)")
            throw error
        }
    }
    
    func logout() async throws {
        do {
            try await authService.logout()
            self.currentUser = nil
            self.isLoggedIn = false
            print("Déconnexion réussie, isLoggedIn est maintenant : \(self.isLoggedIn)")

        } catch {
            print("Erreur lors de la déconnexion : \(error.localizedDescription)")
            throw error
        }
    }
    
    private func isAuthenticated() async -> Bool {
        return await authService.isAuthenticated()
    }

}
