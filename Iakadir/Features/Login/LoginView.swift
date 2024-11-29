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
                
                Image("Group 1") // Add this image to your assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color(red: 0.6, green: 0.3, blue: 0.2)) // Brown-ish color for the lines
                    .opacity(0.3)
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
                    Text("Ton assistant cuisine")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .textCase(.uppercase)
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        destination: HomeView(),
                        label: {
                            CustomButton(title: "C'est parti !")
                        }
                    )
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color(hex: "#231D1C"))
        }
    }
}

#Preview {
    LoginView()
}
