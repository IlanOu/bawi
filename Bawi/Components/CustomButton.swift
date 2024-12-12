//
//  Button.swift
//  Bawi
//
//  Created by digital on 28/11/2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var backgroundColor: Color = Color("secondary")
    var foregroundColor: Color = Color("text")
    
    var body: some View {
        Text(title) // Texte du bouton
            .fontWeight(.bold)
            .font(.title3)
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(backgroundColor)
            .cornerRadius(50)
    }
}

#Preview {
    CustomButton(title: "Me connecter")
}
