import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    
    @EnvironmentObject var authState: AuthState
    
    @MainActor
    func logOut() async{
        do {
            try await AuthState().logout()
        } catch {
            print("error -> logout")
        }
        
    }
}
