import SwiftUI

struct LoginView: View {
  @StateObject private var viewModel = LoginViewModel()
  @State private var isSignupPresented = false
  @State private var isLoggedIn = false
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Welcome Back")
        .font(.largeTitle)
        .fontWeight(.bold)
      
      TextField("Email", text: $viewModel.email)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .autocapitalization(.none)
        .keyboardType(.emailAddress)
      
      SecureField("Password", text: $viewModel.password)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      Button(action: {
        Task {
          await viewModel.attemptLogin()
        }
      }) {
        Text("Log In")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.blue)
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
      
      Button("Don't have an account? Sign Up") {
        isSignupPresented = true
      }
    }
    .onChange(of: viewModel.isLoginSuccessful) { success in
      if success {
        isLoggedIn = true
        print("Tu es loggé !")
      }
    }
    .padding()
    .navigationBarHidden(true)
    .background(
      NavigationLink(
        destination: HomeView(),
        isActive: $isLoggedIn,
        label: { EmptyView() }
      )
    )
    .sheet(isPresented: $isSignupPresented) {
      SignupView(isSignupPresented: $isSignupPresented, isLoggedIn: $isLoggedIn)
    }
  }
}

#Preview {
  LoginView()
}
