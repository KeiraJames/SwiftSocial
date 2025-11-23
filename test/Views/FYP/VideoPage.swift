//
//  VideoPage.swift
//  YourApp
//
//  VIEW — Shows one video page, including:
//  • AVPlayer
//  • Like/double-tap
//  • Sidebar with swipe-left profile navigation
//
//  VideoPage.swift
//  test
//
//
//  VideoPage.swift
//  test
//

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

                // VIDEO
                VideoPlayerContainer(player: player)

                // HEART POPUP
                if showHeart {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 120))
                        .position(heartPosition)
                }

                // ===========================
                //   ICONS + CAPTION STACK
                // ===========================
                VStack {
                    Spacer()

                    HStack(alignment: .bottom) {

                        if handPreference == .left {
                            sidebar(in: geo)
                            Spacer()
                        } else {
                            Spacer()
                            sidebar(in: geo)
                        }
                    }
                    .padding(.bottom, 25)

                    // CAPTION ALWAYS LEFT
                    caption
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 100)
                }
            }
            .gesture(tapGestures(in: geo))
        }
    }

    // ===========================
    //   CAPTION (UPDATED)
    // ===========================

    var caption: some View {
        VStack(alignment: .leading, spacing: 4) {

            // USERNAME: bigger + bolder
            Text("@\(video.username)")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .heavy))   // ★ was ~17, now +3px & heavier

            // CAPTION: 2px smaller
            Text(video.caption)
                .foregroundColor(.white.opacity(0.95))
                .font(.system(size: 13))                  // ★ was ~15 → now smaller
        }
    }

    // ===========================
    //   SIDEBAR ICONS
    // ===========================

    func sidebar(in geo: GeometryProxy) -> some View {
        VStack(spacing: 22) {

            Circle()
                .fill(Color(red: 10/255, green: 10/255, blue: 45/255).opacity(0.75))
                .frame(width: 42, height: 42)
                .overlay(
                    Text(String(video.username.prefix(1)))
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                )

            VStack(spacing: 3) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .white)
                    .font(.system(size: 28))
                Text("12.4K")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            VStack(spacing: 3) {
                Image(systemName: "bubble.right")
                    .foregroundColor(.white)
                    .font(.system(size: 26))
                Text("530")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            VStack(spacing: 3) {
                Image(systemName: "bookmark")
                    .foregroundColor(.white)
                Text("Save")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }

            VStack(spacing: 3) {
                Image(systemName: "arrowshape.turn.up.right")
                    .foregroundColor(.white)
                Text("Share")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
            }
        }
        .frame(width: geo.size.width * 0.15)
        .padding(.trailing, handPreference == .right ? 4 : 0)
        .padding(.leading, handPreference == .left ? 4 : 0)
    }

    // ===========================
    //   DOUBLE TAP + PAUSE
    // ===========================

    func tapGestures(in geo: GeometryProxy) -> some Gesture {

        let doubleTap = TapGesture(count: 2)
            .onEnded {
                isLiked = true
                heartPosition = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)

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
