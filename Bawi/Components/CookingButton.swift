import SwiftUI

struct CookingButton: View {
  @Binding var isLoading: Bool
  var cookingViewModel: CookingViewModel
  @State private var apiResponse: String = ""
  
  var body: some View {
    VStack {
      Button(action: {
        Task {
          let result = try await sendRequestToAPI()
          print(result)
          cookingViewModel.logData()
        }
      }) {
        if isLoading {
          CustomButton(title: "Attends, ça charge...")
        } else {
          CustomButton(title: "Cuisinons !")
        }
      }
      .disabled(isLoading)
      
      if !apiResponse.isEmpty {
        Text(apiResponse)
          .padding()
      }
    }
  }

  func sendRequestToAPI() async throws -> String {
    let prompt = cookingViewModel.getPrompt()
    let client = SupabaseClientAuth.shared.client
    
    guard let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
          let supabaseAnonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
      apiResponse = "⚠️ Les clés Supabase (URL ou Anon Key) ne sont pas configurées."
      return ""
    }
    
    let session = try await client.auth.session
    let urlString = "https://\(supabaseUrl).functions.supabase.co/openai"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Use the access token from the current session
    request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")
    
    let body = ["query": prompt, "model": "gpt-4o-mini"]
    request.httpBody = try JSONSerialization.data(withJSONObject: body)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    
    // The response is plain text, so we can convert it directly to a string
    guard let response = String(data: data, encoding: .utf8) else {
      throw NSError(domain: "ChatViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
    }
    
    return response
  }
}
