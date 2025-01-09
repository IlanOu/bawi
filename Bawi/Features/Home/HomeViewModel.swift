import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var authState: AuthState
    
    init(authState: AuthState) {
        self.authState = authState
    }
    
    @MainActor
    func logOut() async{
        do {
            try await authState.logout()
        } catch {
            print("error -> logout")
        }
        
    }
}
