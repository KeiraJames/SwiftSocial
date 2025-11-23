import SwiftUI

struct EmailEntryView: View {
    @State private var email = ""
    let onContinue: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 24) {

            Text("Provide your email")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 80)

            TextField("email@example.com", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            Text("Email verification helps us keep your account secure.")
                .foregroundColor(.gray)
                .font(.system(size: 14))

            Spacer()

            Button(action: { onContinue() }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(email.isEmpty ? Color.gray : Color.black)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty)

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
