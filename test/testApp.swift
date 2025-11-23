import SwiftUI

@main
struct testApp: App {

    @AppStorage("handPreference") var handPreference: HandPreference?

    var body: some Scene {
        WindowGroup {
            if handPreference == nil {
                OnboardingCoordinator()
            } else {
                ContentView()
            }
        }
    }
}
