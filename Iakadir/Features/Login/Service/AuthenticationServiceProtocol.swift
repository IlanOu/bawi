import Combine
import Foundation

protocol AuthenticationServiceProtocol {
  func login(email: String, password: String) -> AnyPublisher<User, Error>
  func signup(email: String, password: String, username: String?) -> AnyPublisher<User, Error>
}
