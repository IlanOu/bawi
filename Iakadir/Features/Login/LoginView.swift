//
//  LoginView.swift
//  Iakadir
//
//  Created by digital on 28/11/2024.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Gradient radial 1
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.purple.opacity(0.9),
                        Color.black.opacity(0.9)
                    ]),
                    center: .bottomLeading,
                    startRadius: 5,
                    endRadius: 500
                )
                .ignoresSafeArea()
                
                // Gradient radial 2
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.indigo.opacity(0.2),
                        Color.black.opacity(0)
                    ]),
                    center: .topTrailing,
                    startRadius: 1,
                    endRadius: 400
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Logo
                    Image(systemName: "globe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.indigo)
                        .frame(width: 250, height: 250)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    // Titre
                    Text("Ton assistant IA, au quotidien")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        destination: HomeView(),
                        label: {
                            CustomButton(
                                title: "Commencer",
                                backgroundColor: .white,
                                foregroundColor: .black
                            )
                        }
                    )
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
