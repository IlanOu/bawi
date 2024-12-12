import SwiftUI

struct CookingButton: View {
  @Binding var isLoading: Bool
  @EnvironmentObject var discussionManager: DiscussionManager
  var cookingViewModel: CookingViewModel
  @State private var apiResponse: String = ""
  @State private var showResultView: Bool = false
  @State private var savedDiscussions: [String] = []
  
  var body: some View {
      VStack {
        Button(action: {
          isLoading = true
          showResultView = true
          Task {
            do {
              apiResponse = try await sendRequestToAPI()
              discussionManager.addDiscussion(apiResponse)
              isLoading = false
            } catch {
              apiResponse = "Erreur : \(error.localizedDescription)"
              isLoading = false
            }
          }
        }) {
          CustomButton(title: "Cuisinons !")
        }
        .disabled(isLoading)
        
        // NavigationLink déclenchée dès que le bouton est pressé
        NavigationLink(
          destination: MarkdownView(content: apiResponse, isLoading: $isLoading),
          isActive: $showResultView
        ) {
          EmptyView()
        }
        .hidden()
      }
    }
  
  func sendRequestToAPI() async throws -> String {
    let prompt = cookingViewModel.getPrompt()
    let client = SupabaseClientAuth.shared.client
    
    guard let supabaseUrl = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
          let _ = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String else {
      return "⚠️ Les clés Supabase (URL ou Anon Key) ne sont pas configurées."
    }
    
    let session = try await client.auth.session
    let urlString = "https://\(supabaseUrl).functions.supabase.co/openai"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")
    
    let body = ["query": prompt, "model": "gpt-4o-mini"]
    request.httpBody = try JSONSerialization.data(withJSONObject: body)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    guard let response = String(data: data, encoding: .utf8) else {
      throw NSError(domain: "ChatViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
    }
        
    return response
  }
}
