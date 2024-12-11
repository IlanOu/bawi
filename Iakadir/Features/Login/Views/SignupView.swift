import SwiftUI

struct SignupView: View {
  @StateObject private var viewModel = SignupViewModel()
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    NavigationView {
      VStack(spacing: 20) {
        Text("Create Account")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        TextField("Email", text: $viewModel.email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)
          .keyboardType(.emailAddress)
        
        TextField("Username", text: $viewModel.username)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .autocapitalization(.none)
        
        SecureField("Password", text: $viewModel.password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        
        SecureField("Confirm Password", text: $viewModel.confirmPassword)
          .textFieldStyle(RoundedBorderTextFieldStyle())
        
        Button(action: {
          Task {
            await viewModel.signup()
            }
          }) {
          Text("Sign Up")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(viewModel.isLoading)
        
        if viewModel.isLoading {
          ProgressView()
        }
        
        if let error = viewModel.error {
          Text(error)
            .foregroundColor(.red)
        }
        
        Spacer()
      }
      .padding()
      .navigationBarItems(leading: Button("Cancel") {
        presentationMode.wrappedValue.dismiss()
      })
    }
  }
}

#Preview {
  LoginView()
}
