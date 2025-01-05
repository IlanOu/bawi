import Foundation
import Supabase

class SupabaseClientAuth {
  static let shared = SupabaseClientAuth()
  
  let client: SupabaseClient
  
  private init() {
    guard let supabaseUrl = Config.supabaseUrl,
          let supabaseAnonKey = Config.supabaseAnonKey else {
        fatalError("⚠️ Les clés Supabase (URL ou Anon Key) ne sont pas configurées.")
    }
    
    self.client = SupabaseClient(
      supabaseURL: URL(string: "https://\(supabaseUrl).supabase.co")!,
      supabaseKey: supabaseAnonKey
    )
    
  }
}
