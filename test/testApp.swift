//import SwiftUI
//
//@main
//struct testApp: App {
//
//    @AppStorage("handPreference") var handPreference: HandPreference?
//
//    var body: some Scene {
//        WindowGroup {
//            if handPreference == nil {
//                OnboardingCoordinator()
//            } else {
//                ContentView()
//            }
//        }
//    }
//}
//
//  testApp.swift
//  test
//

import SwiftUI

@main
struct testApp: App {

    // Force onboarding EVERY TIME
    @AppStorage("didFinishOnboarding") var didFinishOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {

            // 👇 ALWAYS SHOW ONBOARDING FOR TESTING
            OnboardingCoordinator()
                .onAppear {
                    didFinishOnboarding = false  // <-- resets on launch
                }
        }
    }
}
