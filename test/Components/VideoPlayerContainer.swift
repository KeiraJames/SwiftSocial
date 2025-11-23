//
//  VideoPlayerContainer.swift
//  YourApp
//
//  COMPONENT — Wraps AVPlayerViewController for use in SwiftUI.
//

import SwiftUI
import AVKit

struct VideoPlayerContainer: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let vc = AVPlayerViewController()
        vc.player = player
        vc.showsPlaybackControls = false
        vc.videoGravity = .resizeAspectFill
        return vc
    }

    func updateUIViewController(_ uiVC: AVPlayerViewController, context: Context) {}
}
