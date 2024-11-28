//
//  Button.swift
//  Iakadir
//
//  Created by digital on 28/11/2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color
    var foregroundColor: Color
    
    var body: some View {
        Text(title) // Texte du bouton
            .fontWeight(.bold)
            .font(.title2)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.all, 24)
            .background(backgroundColor)
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            .padding(.vertical, 10)
    }
}

#Preview {
    CustomButton(title: "Commencer", backgroundColor: .white, foregroundColor: .black)
}
