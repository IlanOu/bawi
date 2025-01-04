import Foundation

struct Discussion: Identifiable, Codable, Hashable {
    let id: UUID
    var text: String
    var ingredients: [Ingredient]
}


class DiscussionManager: ObservableObject {
    static let shared = DiscussionManager()
    
    @Published var discussions: [Discussion] = []
    @Published var model: String = "gpt-4o-mini"
    
    private init() {
        loadDiscussions()
    }
    
    func addDiscussion(text: String, ingredients: [Ingredient]) {
        let newDiscussion = Discussion(id: UUID(), text: text, ingredients: ingredients)
        discussions.append(newDiscussion)
        saveDiscussions()
    }
    
    func removeDiscussion(_ discussion: Discussion) {
        discussions.removeAll { $0.id == discussion.id }
        saveDiscussions()
    }
    
    private func saveDiscussions() {
        if let encoded = try? JSONEncoder().encode(discussions) {
            UserDefaults.standard.set(encoded, forKey: "SavedDiscussions")
        }
    }
    
    private func loadDiscussions() {
        if let savedData = UserDefaults.standard.data(forKey: "SavedDiscussions"),
           let decoded = try? JSONDecoder().decode([Discussion].self, from: savedData) {
            discussions = decoded
        }
    }
}
