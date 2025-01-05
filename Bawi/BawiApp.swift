import SwiftUI

@main
struct BawiApp: App {
    @StateObject private var authState = AuthState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authState)
        }
    }
}
