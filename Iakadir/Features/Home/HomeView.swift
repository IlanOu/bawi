import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient background
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(hex: "1A1A1A")]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header section that doesn't scroll
                    header
                    
                    // Scrollable content
                    ScrollView {
                        content
                            .padding(.top, 24)
                    }
                    .padding(.top, 10) // To offset the top padding from the ScrollView and avoid extra space
                }
            }
            .navigationBarHidden(true)
        }
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
            Text("Qu'est-ce que tu\nveux faire ?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top, 16)
            
            // Action cards grid
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ActionCard(title: "Résumer\nun son",
                           icon: "waveform",
                           color: Color(hex: "A4E53A"))
                
                ActionCard(title: "Parler à l'IA",
                           icon: "message",
                           color: Color(hex: "9747FF"))
                
                ActionCard(title: "Générer une image",
                           icon: "photo",
                           color: Color(hex: "FF7EB0"))
                    .gridCellColumns(2)
            }
            .padding(.horizontal)
            
            // History section
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

struct ActionCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                    Spacer()
                    Image(systemName: "arrow.up.right")
                        .font(.caption)
                }
                Spacer()
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
            .foregroundColor(.black)
            .padding()
            .frame(height: 120)
            .background(color)
            .cornerRadius(16)
        }
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
