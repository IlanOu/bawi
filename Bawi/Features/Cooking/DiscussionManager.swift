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
  
    func removeDiscussion(_ discussion: String) {
        if let index = discussions.firstIndex(of: discussion) {
            discussions.remove(at: index)
            saveDiscussions() // N'oubliez pas de sauvegarder après la suppression
        }
    }
}
