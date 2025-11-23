//
//  FYPViewModel.swift
//  YourApp
//
//  VIEWMODEL — Stores state for the For You Page (FYP), including:
//  • vertical swipe logic
//  • which video is active
//  • opening/closing profile
//  • connecting to VideoManager
//
//
//
//  FYPViewModel.swift
//  test
//

import SwiftUI
import AVKit

class FYPViewModel: ObservableObject {

    // --------------------------------------------------------
    // MARK: VIDEO DATA
    // --------------------------------------------------------

    @Published var videos: [VideoItem] = [
        VideoItem(filename: "video1_opt", username: "Ember Street Kitchen",
                  caption: "Serving flavors you’ll crave all week.", sound: "", likers: ["person1", "person2", "person3"]),
        VideoItem(filename: "video2_opt", username: "Brush & Brew Studio",
                  caption: "Create something you’ll actually want to keep.", sound: "", likers: ["person1", "person2", "person3"]),
        VideoItem(filename: "video3_opt", username: "QC Spa",
                  caption: "Relax and rejuvenate.", sound: "", likers: ["person1", "person2", "person3"])
    ]

    @Published var activeIndex: Int = 0
    @Published var dragOffset: CGFloat = 0

    let screenHeight = UIScreen.main.bounds.height
    private let videoManager = VideoManager.shared

    // --------------------------------------------------------
    // MARK: PROFILE SWIPE STATE
    // --------------------------------------------------------

    @Published var horizontalDrag: CGFloat = 0
    @Published var showingProfile: Bool = false
    @Published var isDraggingToProfile: Bool = false
    @Published var profileUsername: String = ""

    // --------------------------------------------------------
    // MARK: RESERVATION OVERLAY
    // --------------------------------------------------------

    @Published var showingReservation: Bool = false
    @Published var reservationOpacity: Double = 0

    // --------------------------------------------------------
    // MARK: INITIALIZATION
    // --------------------------------------------------------

    func onAppear() {
        if let first = videos.first {
            videoManager.play(first.id)
        }
    }

    // --------------------------------------------------------
    // MARK: VIDEO CONTROLS
    // --------------------------------------------------------

    func pauseAllVideos() {
        videoManager.pauseAll()
    }

    func resumeCurrentVideo() {
        videoManager.play(videos[activeIndex].id)
    }

    // --------------------------------------------------------
    // MARK: VERTICAL SWIPE
    // --------------------------------------------------------

    func handleVerticalSwipe(_ translation: CGFloat) {
        let threshold: CGFloat = 70

        if translation < -threshold && activeIndex < videos.count - 1 {
            activeIndex += 1
        } else if translation > threshold && activeIndex > 0 {
            activeIndex -= 1
        }

        dragOffset = 0
        videoManager.play(videos[activeIndex].id)
    }

    func offsetForIndex(_ index: Int) -> CGFloat {
        CGFloat(index - activeIndex) * screenHeight + dragOffset
    }

    // --------------------------------------------------------
    // MARK: PROFILE SWIPE
    // --------------------------------------------------------

    func startDraggingProfile() {
        if showingProfile { return }
        isDraggingToProfile = true
        profileUsername = videos[activeIndex].username
        videoManager.pauseAll()
    }

    func resumeAfterProfileClose() {
        videoManager.play(videos[activeIndex].id)
        isDraggingToProfile = false
    }

    // --------------------------------------------------------
    // MARK: RESERVATION LOGIC
    // --------------------------------------------------------

    func triggerReservation() {
        videoManager.pauseAll()
        showingReservation = true

        // Fade in
        withAnimation(.easeIn(duration: 0.31)) {
            reservationOpacity = 1
        }

        // Hold 1.5 sec then fade out
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeOut(duration: 0.35)) {
                self.reservationOpacity = 0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.showingReservation = false
                self.videoManager.play(self.videos[self.activeIndex].id)
            }
        }
    }
}
