import SwiftUI

struct CookingButton: View {
  @Binding var isLoading: Bool
  var cookingViewModel: CookingViewModel
  @State private var apiResponse: String = ""
  
  var body: some View {
    VStack {
      Button(action: {
        Task {
          await sendRequestToAPI()
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
  
  private func sendRequestToAPI() async {
    isLoading = true
    defer { isLoading = false }
    
    let prompt = cookingViewModel.getPrompt()
    let client = SupabaseClientAuth.shared.client
    
    guard let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
          let supabaseAnonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
      apiResponse = "⚠️ Les clés Supabase (URL ou Anon Key) ne sont pas configurées."
      return
    }
    
    do {
      let session = try await client.auth.session
      
      let urlString = "https://\(supabaseUrl).supabase.co/functions/v1/openai"
      guard let url = URL(string: urlString) else {
        apiResponse = "URL invalide"
        return
      }
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")
      request.setValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
      
      let body = ["prompt": prompt, "model": "gpt-4-mini"]
      request.httpBody = try JSONSerialization.data(withJSONObject: body)
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw NSError(domain: "CookingButton", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
      }
      
      if httpResponse.statusCode != 200 {
        throw NSError(domain: "CookingButton", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server responded with status code \(httpResponse.statusCode)"])
      }
      
      if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        print("JSON Response: \(jsonResult)")
        if let message = jsonResult["message"] as? String {
          apiResponse = message
        } else {
          apiResponse = "Réponse inattendue du serveur"
        }
      } else if let responseString = String(data: data, encoding: .utf8) {
        apiResponse = responseString
      } else {
        throw NSError(domain: "CookingButton", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
      }
      
    } catch {
      if let error = error as? URLError {
        apiResponse = "Erreur réseau : \(error.localizedDescription)"
        print("URLError: \(error.code.rawValue) - \(error.localizedDescription)")
      } else {
        apiResponse = "Erreur : \(error.localizedDescription)"
        print("Erreur lors de la connexion avec Supabase : \(error)")
      }
    }
  }
}
