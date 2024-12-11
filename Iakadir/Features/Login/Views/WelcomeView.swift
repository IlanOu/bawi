//
//  LoginView.swift
//  Iakadir
//
//  Created by digital on 28/11/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("Group 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .clipped()
                
                VStack {
                    Spacer()
                    
                    Text("Iakadir")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .textCase(.uppercase)
                    
                    Spacer()
                    
                    
                    // Logo
                    Image("ramen")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 350)
                    
                    Spacer()
                    
                    // Titre
                    Text("Ton assistant de cuisine")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .textCase(.uppercase)
                    
                    Spacer()
                    
                    
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            CustomButton(title: "C'est parti !")
                        }
                    )
                    
                    Spacer()
                }
                .padding()
            }
            .background(Color("primary"))
        }
    }
}

#Preview {
    WelcomeView()
}
