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
        request.setValue("Bearer \(session.accessToken)", forHTTPHeaderField: "Authorization")
        
        print("Il y'a une image ? -> \(String(describing: cookingViewModel.selectedImage))")
        
        if let image = cookingViewModel.selectedImage {
            let prompt = cookingViewModel.getPrompt()
            let imageData = image.jpegData(compressionQuality: 0.8)
            let base64Image = imageData?.base64EncodedString() ?? ""
            
            let body: [String: Any] = [
                "model": "gpt-4o",
                "messages": [
                    [
                        "role": "user",
                        "content": [
                            [
                                "type": "text",
                                "text": prompt
                            ],
                            [
                                "type": "image_url",
                                "image_url": [
                                    "url": "data:image/jpeg;base64,\(base64Image)"
                                ]
                            ]
                        ]
                    ]
                ],
                "max_tokens": 300
            ]

            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            // Cas où il n'y a pas d'image
            let prompt = cookingViewModel.getPrompt()
            let body: [String: Any] = [
                "model": "gpt-4o",
                "messages": [
                    [
                        "role": "user",
                        "content": prompt
                    ]
                ],
                "max_tokens": 300
            ]
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let response = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "CookingButton", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
        }
        
        return response
    }

}
