import SwiftUI

struct SignupView: View {
  @StateObject private var viewModel = SignupViewModel()
  @Binding var isSignupPresented: Bool
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Create Account")
        .font(.largeTitle)
        .fontWeight(.bold)
      
      TextField("Email", text: $viewModel.email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
      
      SecureField("Password", text: $viewModel.password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      SecureField("Confirm Password", text: $viewModel.confirmPassword)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: {
        Task {
          await viewModel.signup()
          if viewModel.isSignupSuccessful {
            isLoggedIn = true
            isSignupPresented = false
          }
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
  }
}

#Preview {
  SignupView(isSignupPresented: .constant(true), isLoggedIn: .constant(false))
}
