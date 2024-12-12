import MarkdownUI
import SwiftUI

struct MarkdownView: View {
    var content: String
    @Binding var isLoading: Bool

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Chargement...")
            } else {
                Markdown(content)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
            }
        }
        .navigationTitle(isLoading ? "Chargement..." : "Résultat")
    }
}
