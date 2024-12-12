import SwiftUI

struct AllDiscussionsView: View {
    @EnvironmentObject var discussionManager: DiscussionManager
    @State private var isLoading = false

    var body: some View {
        VStack {
            Text("Historique complet")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            if discussionManager.discussions.isEmpty {
                Text("Aucune discussion enregistrée.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(discussionManager.discussions, id: \.self) { discussion in
                    NavigationLink(destination: MarkdownView(content: discussion, isLoading: $isLoading)) {
                        HStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: "waveform")
                                        .foregroundColor(.white)
                                )

                            Text(discussion)
                                .lineLimit(1)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationBarTitle("Discussions", displayMode: .inline)
    }
}
