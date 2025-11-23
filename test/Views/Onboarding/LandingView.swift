//
//  LandingView.swift
//  test
//
//  Created by Keira James on 11/23/25.
//
//
//  LandingView.swift
//  test
//

import SwiftUI

struct LandingView: View {

    var onContinue: () -> Void

    var body: some View {
        VStack(spacing: 40) {

            Spacer().frame(height: 60)

            // Icon at top
            Image(systemName: "sparkles")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 20)

            // Title
            Text("Welcome to Test App")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Text("Let’s set up your account.\nThis only takes a moment.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: onContinue) {
                Text("Get Started")
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .ignoresSafeArea()
    }
}
