//
//  ProfileView.swift
//  YourApp
//
//  VIEW — Slide-in profile screen with drag-right-to-close.
//

//
//  ProfileView.swift
//  test
//

import SwiftUI

struct ProfileView: View {

    let username: String

    var body: some View {

        ZStack {
            // FULL SCREEN BACKGROUND
            Color.black
                .ignoresSafeArea()

            VStack {

                // USERNAME HEADER
                Text("@\(username)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 60)

                Spacer()

                // Simple prompt text
                Text("Swipe right to go back")
                    .foregroundColor(.gray)
                    .padding(.bottom, 80)
            }
        }
        // No gestures here.
        // All swipe interactions handled by FYPView + ContentView.
    }
}
