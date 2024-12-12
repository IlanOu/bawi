import Foundation
import Supabase

class AuthenticationService: AuthenticationServiceProtocol {
  
  private let client = SupabaseClientAuth.shared.client
  
  
  func login(email: String, password: String) async throws -> (User, String) {
    do {
      let authResponse = try await self.client.auth.signIn(email: email, password: password)
      
      let user = authResponse.user
      let accessToken = authResponse.accessToken
            
      return (User(id: user.id, email: user.email ?? ""), accessToken)
      
    } catch {
      print("Erreur lors de la connexion avec Supabase : \(error.localizedDescription)")
      throw error
    }
  }
  
  func signup(email: String, password: String) async throws -> (User, String) {
    do {
      let authResponse = try await self.client.auth.signUp(email: email, password: password)
      let user = authResponse.user

      let accessToken = authResponse.session?.accessToken ?? ""
      
      return (User(id: user.id, email: user.email ?? ""), accessToken)
      
    } catch {
      print("Erreur lors de l'inscription : \(error.localizedDescription)")
      throw error
    }
  }
}

enum AuthError: Error {
  case userNotFound
  case userCreationFailed
  case usernameMissing
}
