import SwiftUI

struct HomeView: View {
    @StateObject private var cookingViewModel = CookingViewModel()
  
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("Group 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .clipped()
                
                VStack(spacing: 0) {
                    // Header section that doesn't scroll
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
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
    
    // Header view
    private var header: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                }
                HStack(spacing: 8) {
                    Spacer()
                    Text("Hello, ma flend")
                        .foregroundColor(.white)
                    Text("👋")
                    Spacer()
                    ProBadge()
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 24)
        }
    }
    
    // Scrollable content view
    private var content: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Qu'est-ce que tu veux faire ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 16)
            
            // Disposition personnalisée des cartes
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    // Première carte occupant deux lignes
                    ActionCard(
                        title: "Préparer un plat",
                        icon: "waveform",
                        color: Color("secondary"),
                        destination:
                          CookingView()
                          .environmentObject(cookingViewModel),
                        height: 250
                    )
                    
                    VStack(spacing: 16) {
                        // Deuxième carte
                        ActionCard(
                            title: "Courses à venir",
                            icon: "message",
                            color: Color(hex: "9747FF"),
                            destination: ShoppingView()
                        )
                        
                        // Troisième carte
                        ActionCard(
                            title: "Bientôt disponible",
                            icon: "photo",
                            color: Color(Color.white.opacity(0.25)),
                            destination: nil as EmptyView?)
                    }
                }
            }
            .padding(.horizontal)
            
            // Historique
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Historique")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Button("Voir tout") {
                        // Action
                    }
                    .foregroundColor(.gray)
                }
                
                ForEach(0..<3) { _ in
                    HistoryItem()
                }
            }
            .padding(.horizontal)
        }
    }


}

struct ProBadge: View {
    var body: some View {
        Text("PRO +")
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.purple)
            .cornerRadius(12)
    }
}


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
            if (height > 120){
                Text(title)
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }else{
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



struct HistoryItem: View {
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "waveform")
                            .foregroundColor(.white)
                    )
                
                Text("Swift est un langage de programmation...")
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Spacer()
                
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
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
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

#Preview{
  HomeView()
}
