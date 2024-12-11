import Foundation

enum Config {
  static let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String
  static let supabaseAnonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String
}
