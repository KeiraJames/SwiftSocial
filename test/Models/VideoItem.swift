//
//  VideoItem.swift
//  YourApp
//
//  MODEL — Represents one TikTok-style video in the feed.
//

import Foundation

struct VideoItem: Identifiable {
    let id = UUID()
    let filename: String        // Name of the mp4 file in your bundle
    let username: String        // Creator username
    let caption: String         // Video caption
    let sound: String           // Sound name or attribution
}
