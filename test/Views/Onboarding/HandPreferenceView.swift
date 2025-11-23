import SwiftUI

struct HandPreferenceView: View {

    @AppStorage("handPreference") var handPreference: HandPreference?
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 40) {

            Text("Which hand do you use?")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 80)

            VStack(spacing: 20) {

                Button(action: {
                    handPreference = .left
                    onContinue()
                }) {
                    Text("Left Handed")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }

                Button(action: {
                    handPreference = .right
                    onContinue()
                }) {
                    Text("Right Handed")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
