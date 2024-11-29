//
//  Button.swift
//  Iakadir
//
//  Created by digital on 28/11/2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color = Color(hex: "#FD8450")
    var foregroundColor: Color = .white
    
    var body: some View {
        Text(title) // Texte du bouton
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(backgroundColor)
            .cornerRadius(50)
    }
}

#Preview {
    CustomButton(title: "Me connecter")
}
