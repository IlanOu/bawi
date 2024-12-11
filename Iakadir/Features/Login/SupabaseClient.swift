import Foundation
import Supabase

class SupabaseClient {
  static let shared = SupabaseClient()
  
  let client: SupabaseClient
  
  private init() {
    guard let supabaseURL = Config.supabaseUrl,
          let supabaseAnonKey = Config.supabaseAnonKey,
          !supabaseURL.isEmpty, !supabaseAnonKey.isEmpty else {
      fatalError("Supabase URL and Anon Key must be set in Config.xcconfig")
    }
    
    self.client = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseAnonKey)
  }
}
