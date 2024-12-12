import Foundation

class DiscussionManager: ObservableObject {
    static let shared = DiscussionManager()
    
    @Published var discussions: [String] = []
    
    private init() {
        loadDiscussions()
    }
    
    func addDiscussion(_ discussion: String) {
        discussions.append(discussion)
        saveDiscussions()
    }
    
    private func saveDiscussions() {
        UserDefaults.standard.set(discussions, forKey: "SavedDiscussions")
    }
    
    private func loadDiscussions() {
        discussions = UserDefaults.standard.stringArray(forKey: "SavedDiscussions") ?? []
    }
  
    func removeDiscussion(at offsets: IndexSet) {
      discussions.remove(atOffsets: offsets)
    }
}
