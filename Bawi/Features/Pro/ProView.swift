import SwiftUI

struct ProView: View {
    var body: some View {
        ZStack {
            // Background color
            Color("primary")
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                // Header Section
                VStack(spacing: 12) {
                    Text("Devenez Pro !")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color("text"))
                        .multilineTextAlignment(.center)
                    
                    Text("Profitez de toutes les fonctionnalités premium et transformez votre expérience utilisateur dès aujourd'hui.")
                        .font(.body)
                        .foregroundColor(Color("text").opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 20)
                
                // Plan Cards Section
                VStack(spacing: 16) {
                    PlanCard(
                        title: "Classique",
                        price: "Gratuit (Actif)",
                        features: ["Accès limité : 3 interactions / semaine"],
                        color: Color("secondary")
                    )
                    
                    PlanCard(
                        title: "Mensuel",
                        price: "9,99€",
                        features: ["Accès illimité", "Modèle d'IA plus malin"],
                        color: Color(hex: "9747FF")
                    )
                    
                    PlanCard(
                        title: "Annuel",
                        price: "99,99€",
                        features: ["Accès illimité", "Modèle d'IA plus malin", "2 mois offerts"],
                        color: Color.green
                    )
                }
                .padding(.horizontal, 16)
                
                // Call to Action Button
                CustomButton(title: "S'abonner maintenant")
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
            }
        }
    }
}

struct PlanCard: View {
    let title: String
    let price: String
    let features: [String]
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("text"))
                
                Spacer()
                
                Text(price)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color("text"))
            }
            
            ForEach(features, id: \.self) { feature in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color("text"))
                        .font(.headline)
                    
                    Text(feature)
                        .font(.body)
                        .foregroundColor(Color("text").opacity(0.9))
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            color
                .opacity(0.9)
                .cornerRadius(16)
                .shadow(color: color.opacity(0.4), radius: 8, x: 0, y: 4)
        )
    }
}
