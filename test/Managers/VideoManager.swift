//
//  VideoManager.swift
//  YourApp
//
//  MANAGER — Handles AVPlayer creation, caching, looping, pausing, etc.
//  ViewModels and Views depend on this class.
//

import Foundation
import AVKit
import SwiftUI

class VideoManager: ObservableObject {
    static let shared = VideoManager()

    @Published var players: [UUID: AVPlayer] = [:]

    func player(for video: VideoItem) -> AVPlayer {
        if let existing = players[video.id] {
            return existing
        }

        guard let url = Bundle.main.url(forResource: video.filename, withExtension: "mp4") else {
            fatalError("Missing video file: \(video.filename).mp4")
        }

        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            player.seek(to: .zero)
            player.play()
        }

        players[video.id] = player
        return player
    }

    // Plays only the active player's video
    func play(_ id: UUID) {
        for (vid, player) in players {
            if vid == id {
                player.seek(to: .zero)
                player.play()
            } else {
                player.pause()
                player.seek(to: .zero)
            }
        }
    }

    func pauseAll() {
        for (_, player) in players {
            player.pause()
        }
    }
}
