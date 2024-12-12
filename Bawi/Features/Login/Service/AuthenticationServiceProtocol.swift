import Foundation

protocol AuthenticationServiceProtocol {
  func login(email: String, password: String) async throws -> (User, String)
  func signup(email: String, password: String) async throws -> (User, String)
}
