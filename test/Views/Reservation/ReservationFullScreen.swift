//
//  ReservationFullScreen.swift
//  test
//

import SwiftUI

struct ReservationFullScreen: View {

    @ObservedObject var viewModel: FYPViewModel

    var body: some View {
        let navyBlue = Color(red: 10/255, green: 10/255, blue: 45/255)

        ZStack {
            Color.white
                .opacity(viewModel.reservationOpacity)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 88))
                    .foregroundColor(navyBlue)
                    .opacity(viewModel.reservationOpacity)

                Text("Reservation Confirmed")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.black)
                    .opacity(viewModel.reservationOpacity)

                Text("Added to your calendar")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                    .opacity(viewModel.reservationOpacity)
            }
        }
    }
}
