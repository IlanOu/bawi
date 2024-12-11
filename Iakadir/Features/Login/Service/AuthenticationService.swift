import Foundation
import Combine
import Supabase

class AuthenticationService: AuthenticationServiceProtocol {
  private let client = SupabaseClient.shared.client
  
  func login(email: String, password: String) -> AnyPublisher<User, Error> {
    return Future { promise in
      Task {
        do {
          let authResponse = try await self.client.auth.signIn(email: email, password: password)
          if let user = authResponse.user {
            promise(.success(User(id: user.id, email: user.email ?? "", username: user.userMetadata["username"] as? String)))
          } else {
            promise(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
          }
        } catch {
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func signup(email: String, password: String, username: String?) -> AnyPublisher<User, Error> {
    return Future { promise in
      Task {
        do {
          let authResponse = try await self.client.auth.signUp(email: email, password: password, data: ["username": username ?? ""])
          if let user = authResponse.user {
            promise(.success(User(id: user.id, email: user.email ?? "", username: username)))
          } else {
            promise(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "User creation failed"])))
          }
        } catch {
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
}
