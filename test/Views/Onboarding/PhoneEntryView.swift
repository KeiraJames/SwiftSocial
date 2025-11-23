import SwiftUI

struct PhoneEntryView: View {
    @State private var phone = ""
    let onContinue: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Text("What's your phone number?")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 80)

            TextField("+1 (555) 555-5555", text: $phone)
                .keyboardType(.phonePad)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)

            Spacer()

            Button(action: { onContinue() }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(phone.isEmpty ? Color.gray : Color.black)
                    .cornerRadius(10)
            }
            .disabled(phone.isEmpty)

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
