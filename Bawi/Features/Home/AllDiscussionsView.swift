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
                List {
                    ForEach(discussionManager.discussions.reversed(), id: \.self) { discussion in
                        HStack {
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
                            }
                            
                            Spacer()
                            
                            Menu {
                                Button(action: {
                                    discussionManager.removeDiscussion(discussion)
                                }) {
                                    Label("Supprimer", systemImage: "trash")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                            }
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
