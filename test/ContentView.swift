import SwiftUI
import AVKit

struct ContentView: View {

    // MARK: - Video Model (class to avoid SwiftUI struct capture errors)
    class VideoItem: Identifiable {
        let id = UUID()
        let player: AVPlayer

        init?(name: String) {
            guard let url = Bundle.main.url(forResource: name, withExtension: "mp4") else {
                print("❌ Could not load video:", name)
                return nil
            }

            self.player = AVPlayer(url: url)

            // Loop the video
            NotificationCenter.default.addObserver(
                forName: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem,
                queue: .main
            ) { [weak player] _ in
                player?.seek(to: .zero)
                player?.play()
            }
        }
    }

    // MARK: - Videos List
    @State private var videos: [VideoItem] = []
    @State private var currentIndex: Int = 0

    init() {
        let names = ["video1", "video2", "video3"]

        // Debug load test
        names.forEach {
            if Bundle.main.url(forResource: $0, withExtension: "mp4") == nil {
                print("⚠️ Missing video:", $0)
            } else {
                print("✅ Found video:", $0)
            }
        }

        _videos = State(initialValue: names.compactMap { VideoItem(name: $0) })
    }

    var body: some View {

        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(videos.indices, id: \.self) { index in
                    ZStack {
                        VideoPlayerContainer(player: videos[index].player)
                            .frame(height: UIScreen.main.bounds.height)
                            .clipped()
                            .onAppear { playVideo(index) }

                        overlayUI(index: index)
                    }
                }
            }
        }
        .scrollTargetBehavior(.paging)  // vertical TikTok swipe
        .ignoresSafeArea()
    }

    // MARK: - Overlay UI
    func overlayUI(index: Int) -> some View {
        VStack {
            Spacer()

            HStack(alignment: .bottom) {

                VStack(alignment: .leading, spacing: 6) {
                    Text("@video\(index + 1)")
                        .foregroundColor(.white)
                        .font(.headline)

                    Text("This is video \(index + 1).\n#SwiftUI #TikTokClone")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }

                Spacer()

                VStack(spacing: 28) {
                    VStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                        Text("12.4K")
                            .foregroundColor(.white)
                            .font(.caption)
                    }

                    VStack {
                        Image(systemName: "bubble.right.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                        Text("340")
                            .foregroundColor(.white)
                            .font(.caption)
                    }

                    VStack {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                        Text("Share")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
                .padding(.trailing, 20)
            }
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Playback Logic
    private func playVideo(_ index: Int) {
        videos.forEach { $0.player.pause() }        // pause others
        let player = videos[index].player
        player.seek(to: .zero)
        player.play()
    }
}

// MARK: - Video Player Wrapper
struct VideoPlayerContainer: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }
}
