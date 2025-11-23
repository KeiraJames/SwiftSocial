import SwiftUI

struct OnboardingCoordinator: View {

    enum Step {
        case phone
        case email
        case hand
        case done
    }

    @State private var step: Step = .phone

    var body: some View {
        switch step {

        case .phone:
            PhoneEntryView {
                step = .email
            }

        case .email:
            EmailEntryView {
                step = .hand
            }

        case .hand:
            HandPreferenceView {
                step = .done
            }

        case .done:
            ContentView()
        }
    }
}
