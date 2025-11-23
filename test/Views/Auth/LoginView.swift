//
//  LoginView.swift
//  test
//
import SwiftUI

struct LoginView: View {

    @AppStorage("handPreference") var handPreference: HandPreference?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 40) {

                Text("Choose Your Hand Preference")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top, 80)

                VStack(spacing: 20) {

                    Button(action: {
                        handPreference = .left
                    }) {
                        Text("👈 Left-Handed")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(action: {
                        handPreference = .right
                    }) {
                        Text("👉 Right-Handed")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 30)

                Spacer()
            }
        }
    }
}
