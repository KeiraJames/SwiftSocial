//
//  VideoPage.swift
//  test
//

import SwiftUI
import AVKit

struct VideoPage: View {

    let video: VideoItem
    let isActive: Bool
    @ObservedObject var viewModel: FYPViewModel

    @AppStorage("handPreference") var handPreference: HandPreference?

    @State private var isLiked = false
    @State private var showHeart = false
    @State private var heartPosition = CGPoint.zero

    var player: AVPlayer { VideoManager.shared.player(for: video) }

    var body: some View {
        GeometryReader { geo in
            ZStack {

                // ===========================
                // BACKGROUND VIDEO
                // ===========================
                VideoPlayerContainer(player: player)

                // ===========================
                // HEART POPUP
                // ===========================
                if showHeart {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 120))
                        .position(heartPosition)
                }

                // ===========================
                // MAIN LAYOUT STACK
                // ===========================
                VStack {
                    Spacer()

                    // ==========================================
                    // ICONS + FRIEND BUBBLES MIRRORING SIDEBAR
                    // ==========================================
                    HStack(alignment: .bottom) {

                        if handPreference == .left {
                            // LEFT-HANDED → icons left, bubbles right
                            sidebar(in: geo)
                            Spacer()

                            likerBubbles
                                .padding(.bottom, 15)
                                .padding(.trailing, 20)

                        } else {
                            // RIGHT-HANDED → bubbles left, icons right
                            likerBubbles
                                .padding(.bottom, 18)
                                .padding(.leading, 20)

                            Spacer()
                            sidebar(in: geo)
                        }
                    }
                    .padding(.bottom, 25)

                    // ===========================
                    // CAPTION ALWAYS LEFT
                    // ===========================
                    caption
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 100)
                }
                .zIndex(10)
            }
            .gesture(tapGestures(in: geo))
        }
    }

    // ===========================
    // CAPTION
    // ===========================
    var caption: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(video.username)
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .black)) // +3 px and bolder

            Text(video.caption)
                .foregroundColor(.white)
                .font(.system(size: 14)) // 2px smaller
        }
    }

    // ===========================
    // RIGHT/LEFT SIDEBAR ICONS
    // ===========================
    func sidebar(in geo: GeometryProxy) -> some View {
        VStack(spacing: 22) {

            // Profile bubble
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 42, height: 42)
                .overlay(
                    Text(String(video.username.prefix(1)))
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                )

            // Like button
            VStack(spacing: 3) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .white)
                    .font(.system(size: 28))
                Text("12.4K")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            // Comments button
            VStack(spacing: 3) {
                Image(systemName: "bubble.right")
                    .foregroundColor(.white)
                    .font(.system(size: 26))
                Text("530")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            // Save
            VStack(spacing: 3) {
                Image(systemName: "bookmark")
                    .foregroundColor(.white)
                Text("Save")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            // Share
            VStack(spacing: 3) {
                Image(systemName: "arrowshape.turn.up.right")
                    .foregroundColor(.white)
                Text("Share")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
        }
        .frame(width: geo.size.width * 0.15)
    }

    // ===========================
    // FRIEND BUBBLES (DYNAMIC)
    // ===========================
    var likerBubbles: some View {
        HStack(spacing: -10) { // overlap like Instagram
            ForEach(1...3, id: \.self) { index in
                Image("person\(index)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
        }
    }

    // ===========================
    // DOUBLE TAP + PAUSE
    // ===========================
    func tapGestures(in geo: GeometryProxy) -> some Gesture {

        let doubleTap = TapGesture(count: 2)
            .onEnded {
                isLiked = true
                heartPosition = CGPoint(x: geo.size.width / 2,
                                        y: geo.size.height / 2)

                withAnimation(.easeOut(duration: 0.3)) {
                    showHeart = true
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation { showHeart = false }
                }
            }

        let singleTap = TapGesture()
            .onEnded {
                if player.timeControlStatus == .playing {
                    player.pause()
                } else {
                    player.play()
                }
            }

        return doubleTap.exclusively(before: singleTap)
    }
}
