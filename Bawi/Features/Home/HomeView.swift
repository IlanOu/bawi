import SwiftUI

struct HomeView: View {
    @StateObject private var cookingViewModel = CookingViewModel()
    @StateObject private var discussionManager = DiscussionManager.shared
    
    @EnvironmentObject var authState: AuthState
    @StateObject private var viewModel: HomeViewModel
    
    @State private var isLoading = false
    @State private var apiResponse: String = ""

    init(authState: AuthState) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(authState: authState))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("Group 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .clipped()

                VStack(spacing: 0) {
                    // Header section
                    header

                    // Scrollable content
                    ScrollView {
                        content
                            .padding(.top, 24)
                    }
                    .padding(.top, 10)
                }
            }
            .background(Color("primary"))
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // Header view
    private var header: some View {
        VStack {
            HStack {
                // Menu Button
                Menu {
                    Button(action: {
                        Task {
                            do {
                                await viewModel.logOut()
                                DispatchQueue.main.async {
                                    print("Déconnexion réussie, mise à jour de l'interface")
                                    
                                }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundColor(.red)
                            Text("Se déconnecter")
                                .foregroundColor(.red)
                        }
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(Color("text"))
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                }

                Spacer()

                // Greeting message
                HStack(spacing: 8) {
                    Text("Bienvenue, explorateur")
                        .font(.headline)
                        .foregroundColor(Color("text"))
                    Text("👋")
                }

                Spacer()

                // Pro Badge with navigation
                ProBadge()
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
    }

    // Scrollable content view
    private var content: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title
            Text("Que souhaitez-vous faire ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
                .padding(.horizontal)
                .padding(.top, 16)

            // Action cards
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    // First card
                    ActionCard(
                        title: "Préparer un plat",
                        icon: "waveform",
                        color: Color("secondary"),
                        destination:
                            CookingView()
                            .environmentObject(cookingViewModel)
                            .environmentObject(discussionManager),
                        height: 250
                    )

                    // Second and third cards in a vertical stack
                    VStack(spacing: 16) {
                        /*
                         ActionCard(
                            title: "Courses à venir",
                            icon: "message",
                            color: Color(hex: "9747FF"),
                            destination: ShoppingView()
                        )
                        */
                        ActionCard(
                            title: "Bientôt disponible",
                            icon: "message",
                            color: Color(Color.white.opacity(0.25)),
                            destination: nil as EmptyView?
                        )
                        ActionCard(
                            title: "Bientôt disponible",
                            icon: "photo",
                            color: Color(Color.white.opacity(0.25)),
                            destination: nil as EmptyView?
                        )
                    }
                }
            }
            .padding(.horizontal)

            // History section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Historique")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("text"))
                    Spacer()
                    Button {
                        // Action to show all discussions
                    } label: {
                        NavigationLink(destination: AllDiscussionsView().environmentObject(discussionManager)) {
                            Text("Voir tout")
                                .foregroundColor(.gray)
                        }
                    }
                }

                // Last 3 discussions
                ForEach(discussionManager.discussions.reversed().prefix(3), id: \.self) { discussion in
                    HStack(spacing: 12) {
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
                                    .foregroundColor(Color("text"))
                                    .lineLimit(1)

                                Spacer()
                            }
                        }

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
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
    }
}

// ProBadge
struct ProBadge: View {
    var body: some View {
        NavigationLink(destination: ProView()) {
            Text("PRO +")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color("text"))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.purple)
                .cornerRadius(12)
        }
    }
}

// ActionCard
struct ActionCard<Destination: View>: View {
    let title: String
    let icon: String
    let color: Color
    var destination: Destination?
    var height: CGFloat = 120

    var body: some View {
        Group {
            if let destination = destination {
                NavigationLink(destination: destination) {
                    cardContent
                }
            } else {
                cardContent
            }
        }
        .background(color)
        .cornerRadius(16)
    }

    private var cardContent: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Spacer()
                if destination != nil {
                    Image(systemName: "arrow.up.right")
                        .font(.caption)
                }
            }
            Spacer()
            if height > 120 {
                Text(title)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text(title)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .foregroundColor(.black)
        .padding()
        .frame(height: height)
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}
