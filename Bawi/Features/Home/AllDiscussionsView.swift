import SwiftUI

struct AllDiscussionsView: View {
    @EnvironmentObject var discussionManager: DiscussionManager
    @State private var isLoading = false

    var body: some View {
        ZStack {
            // Background color
            Color("primary")
                .ignoresSafeArea()

            VStack {
                Text("Historique complet")
                    .font(.title)
                    .foregroundColor(Color("text"))
                    .fontWeight(.bold)
                    .padding()

                if discussionManager.discussions.isEmpty {
                    Text("Aucune discussion enregistrée.")
                        .foregroundColor(Color("text").opacity(0.5))
                        .padding()
                } else {
                    List {
                        ForEach(discussionManager.discussions.reversed()) { discussion in
                            HStack {
                                // Navigation Link for Discussion Detail
                                NavigationLink(
                                    destination: MarkdownView(
                                        content: discussion.text,
                                        ingredients: discussion.ingredients,
                                        isLoading: $isLoading
                                    )
                                    .id(discussion.id)
                                ) {
                                    HStack {
                                        Circle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 40, height: 40)
                                            .overlay(
                                                Image(systemName: "waveform")
                                                    .foregroundColor(Color("text"))
                                            )

                                        Text(discussion.text)
                                            .lineLimit(1)
                                            .foregroundColor(Color("text"))
                                            .font(.body)
                                            .padding(.leading, 8)
                                    }
                                    .padding()
                                }

                                Spacer()

                                // Menu for Deletion
                                Menu {
                                    Button(action: {
                                        discussionManager.removeDiscussion(discussion)
                                    }) {
                                        Label("Supprimer", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Color("text").opacity(0.5))
                                        .frame(width: 44, height: 44)
                                        .contentShape(Rectangle())
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.vertical, 4)
                            .background(Color("secondary").opacity(0.1))
                            .cornerRadius(12)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationBarTitle("")
        }
    }
}
