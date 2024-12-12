import Foundation
import Supabase

class SupabaseClientAuth {
  static let shared = SupabaseClientAuth()
  
  let client: SupabaseClient
  
  private init() {
    guard let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
          let supabaseAnonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
      fatalError("⚠️ Les clés Supabase (URL ou Anon Key) ne sont pas configurées.")
    }
    
    self.client = SupabaseClient(
      supabaseURL: URL(string: "https://\(supabaseUrl).supabase.co")!,
      supabaseKey: supabaseAnonKey
    )
    
  }
}
