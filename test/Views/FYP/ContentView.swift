//
//  ContentView.swift
//  test
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = FYPViewModel()
    @State private var selectedTab = "$"
    let tabs = ["$$$$", "$$$", "$$", "$"]

    var body: some View {

        NavigationStack {
            ZStack {

                // ------------------------------------------------
                // FYP MAIN FEED
                // ------------------------------------------------
                FYPView(viewModel: viewModel)
                    .offset(x: -viewModel.horizontalDrag * 0.85)
                    .animation(.none, value: viewModel.horizontalDrag)
                    .zIndex(1)

                // ------------------------------------------------
                // RESERVATION OVERLAY
                // ------------------------------------------------
                if viewModel.showingReservation {
                    ReservationFullScreen(viewModel: viewModel)
                        .padding(.top, 120)
                        .transition(.opacity)
                        .zIndex(5)
                }

                // ------------------------------------------------
                // PROFILE SWIPE-IN VIEW
                // ------------------------------------------------
                GeometryReader { geo in
                    if viewModel.showingProfile || viewModel.isDraggingToProfile {
                        ProfileView(username: viewModel.profileUsername)
                            .frame(width: geo.size.width)
                            .background(Color.black)
                            .offset(x: geo.size.width - viewModel.horizontalDrag)
                            .animation(.none, value: viewModel.horizontalDrag)
                            .gesture(profileDragGesture(in: geo))
                            .zIndex(6)
                    }
                }

                // ------------------------------------------------
                // BOTTOM NAV BAR
                // ------------------------------------------------
                VStack {
                    Spacer()
                    bottomNavBar
                }
                .frame(maxWidth: .infinity)
                .zIndex(10)
            }

            // ------------------------------------------------
            // TOP BAR
            // ------------------------------------------------
            .overlay(alignment: .top) {
                topBar
                    .zIndex(20)
            }

            .ignoresSafeArea()
            .onAppear { viewModel.onAppear() }
        }
    }

    // -----------------------------------------------------
    // MARK: PROFILE SWIPE BACK
    // -----------------------------------------------------
    func profileDragGesture(in geo: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 5)
            .onChanged { value in
                let drag = max(0, -value.translation.width)
                viewModel.isDraggingToProfile = true
                viewModel.horizontalDrag = min(drag, geo.size.width)
            }
            .onEnded { value in
                let drag = max(0, -value.translation.width)
                let threshold = geo.size.width * 0.45

                withAnimation(.interactiveSpring(response: 0.32,
                                                 dampingFraction: 0.72)) {
                    if drag > threshold {
                        viewModel.horizontalDrag = geo.size.width
                        viewModel.showingProfile = true
                    } else {
                        viewModel.horizontalDrag = 0
                        viewModel.showingProfile = false
                        viewModel.resumeAfterProfileClose()
                    }
                }

                viewModel.isDraggingToProfile = false
            }
    }

    // -----------------------------------------------------
    // MARK: TOP BAR (Map + Filters + Search)
    // -----------------------------------------------------
    var topBar: some View {
        HStack {

            // MAP (left)
            Button {
                print("Map tapped")
            } label: {
                Image(systemName: "map")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
            }
            .padding(.leading, 20)

            Spacer()

            // $$$ FILTERS (center)
            HStack(spacing: 36) {
                ForEach(tabs, id: \.self) { tab in
                    VStack(spacing: 3) {
                        Text(tab)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(selectedTab == tab ? .white : .gray)

                        Capsule()
                            .fill(selectedTab == tab ? Color.white : .clear)
                            .frame(width: 22, height: 3)
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.30,
                                              dampingFraction: 0.85)) {
                            selectedTab = tab
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)

            // SEARCH (right)
            NavigationLink {
                SearchView()
                    .onAppear { viewModel.pauseAllVideos() }
                    .onDisappear { viewModel.resumeCurrentVideo() }
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .semibold))
                    .padding(.trailing, 20)
            }
        }
        .padding(.top, 65)
        .padding(.bottom, 4)
    }

    // -----------------------------------------------------
    // MARK: BOTTOM NAV BAR
    // -----------------------------------------------------
    var bottomNavBar: some View {

        let gold = Color(red: 10/255, green: 10/255, blue: 45/255)

        return HStack(spacing: 48) {

            navItem(icon: "house.fill", label: "Home", isActive: true)
            navItem(icon: "person.2.fill", label: "Friends")

            // RESERVE BUTTON
            VStack(spacing: 4) {

                Button {

                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)

                    viewModel.triggerReservation()

                } label: {
                    ZStack {
                        Capsule()
                            .fill(Color.white)
                            .frame(width: 52, height: 32)

                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold))
                    }
                }

                Text("Reserve")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
            }

            navItem(icon: "bubble.left.and.bubble.right.fill", label: "Inbox")
            navItem(icon: "person.crop.circle", label: "Profile")
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
        .frame(height: 86)
        .background(gold.ignoresSafeArea(edges: .bottom))
    }
}

// Helper nav item
@ViewBuilder
func navItem(icon: String, label: String, isActive: Bool = false) -> some View {
    VStack(spacing: 2) {
        Image(systemName: icon)
            .font(.system(size: 20))
            .foregroundColor(isActive ? .white : .gray)

        Text(label)
            .font(.system(size: 10))
            .foregroundColor(isActive ? .white : .gray)
            .fixedSize()
    }
}
