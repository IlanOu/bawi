import SwiftUI

struct SignupView: View {
    
    @Binding var isSignupPresented: Bool
    @State private var isPasswordVisible = false
    
    @EnvironmentObject var authState: AuthState
    
    @StateObject private var viewModel: SignupViewModel

    init(isSignupPresented: Binding<Bool>, authState: AuthState) {
        _isSignupPresented = isSignupPresented
        _viewModel = StateObject(wrappedValue: SignupViewModel(authState: authState))
    }
    
    var body: some View {
        ZStack{
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
                .ignoresSafeArea()
                .clipped()
            
            
            VStack(spacing: 20) {
                
                // Robot icon
                Image("pizza")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color("text"))
                    .frame(width: 100, height: 100)
                
                
                // Title
                Text("Aller, viens")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("text"))
                    .padding(.top, 20)
                
                
                Text("Ça va être sympa !")
                    .foregroundColor(Color("text").opacity(0.8))
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
                
                
                
                // Password field
                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("secondary"))
                    Group {
                        if isPasswordVisible {
                            TextField("Password", text: $viewModel.confirmPassword)
                        } else {
                            SecureField("Password", text: $viewModel.confirmPassword)
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
                
                Button(action: {
                    Task {
                        await viewModel.signup()
                        if viewModel.isSignupSuccessful {
                            authState.isLoggedIn = true
                            isSignupPresented = false
                        }
                    }
                }) {
                    CustomButton(title: "Je m'inscris !")
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
        .background(Color("primary"))
    }
}
