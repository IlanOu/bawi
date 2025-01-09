import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authState: AuthState

    var body: some View {
        VStack {
            if authState.isLoggedIn {
                HomeView(authState: authState)
            } else {
                WelcomeView()
            }
        }
        .onChange(of: authState.isLoggedIn) { newValue in
            // Cette closure sera appelée à chaque fois que isLoggedIn change
            print("isLoggedIn a changé, nouvelle valeur : \(newValue)")
        }
    }
}


#Preview {
    ContentView()
}

