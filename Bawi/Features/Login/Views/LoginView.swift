import SwiftUI

struct LoginView: View {
  @StateObject private var viewModel = LoginViewModel()
  @State private var isSignupPresented = false
  @State private var isLoggedIn = false  // Gérer l'état de la connexion
  
  var body: some View {
    NavigationView {
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
            await viewModel.login()
            if viewModel.isLoginSuccessful {
              isLoggedIn = true  // Rediriger vers HomeView après la connexion réussie
            }
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
      .padding()
      .navigationBarHidden(true)
      .background(
        NavigationLink(
          destination: HomeView(),  // Afficher HomeView si l'utilisateur est connecté
          isActive: $isLoggedIn,  // Lier l'état de connexion
          label: { EmptyView() }
        )
      )
      .sheet(isPresented: $isSignupPresented) {
        SignupView(isSignupPresented: $isSignupPresented, isLoggedIn: $isLoggedIn)  // Passer isLoggedIn ici
      }
    }
  }
}

#Preview {
  LoginView()
}
