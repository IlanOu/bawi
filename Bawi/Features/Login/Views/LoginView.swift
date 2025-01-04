import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isSignupPresented = false
    @State private var isLoggedIn = false
    @State private var isPasswordVisible = false
    
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
                .ignoresSafeArea()
                .clipped()
            
            
            VStack(spacing: 24) {
                // Robot icon
                Image("pizza")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("text"))
                    .frame(width: 100, height: 100)
                
                // Title
                Text("Yo !")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("text"))
                    .padding(.top, 20)
                
                // Sign up text
                HStack(spacing: 4) {
                    Text("T'as pas encore de compte !?")
                        .foregroundColor(Color("text").opacity(0.8))
                    Button("Inscris-toi !") {
                        isSignupPresented = true
                    }
                    .foregroundColor(Color("secondary"))
                }
                .padding(.bottom, 20)
                
                // Email field
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color("secondary"))
                    TextField("Email", text: $viewModel.email)
                        .foregroundColor(Color("text"))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .background(Color.white.opacity(0.15))
                .cornerRadius(12)
                
                // Password field
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("secondary"))
                    Group {
                        if isPasswordVisible {
                            TextField("Password", text: $viewModel.password)
                        } else {
                            SecureField("Password", text: $viewModel.password)
                        }
                    }
                    .foregroundColor(Color("text"))
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.15))
                .cornerRadius(12)
                
                // Login button
                Button(action: {
                    Task {
                        await viewModel.attemptLogin()
                    }
                }) {
                    CustomButton(title: "C'est parti !")
                }
                .padding(.top, 20)
                .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    ProgressView()
                        .tint(Color("text"))
                }
                
                if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
            .onChange(of: viewModel.isLoginSuccessful) { success in
                if success {
                    isLoggedIn = true
                }
            }
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
        .background(Color("primary"))
    }
}

#Preview {
    LoginView()
}
