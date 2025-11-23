//
//  FYPView.swift
//  test
//

import SwiftUI

struct FYPView: View {

    @ObservedObject var viewModel: FYPViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(Array(viewModel.videos.enumerated()), id: \.element.id) { (i, video) in

                    VideoPage(
                        video: video,
                        isActive: i == viewModel.activeIndex,
                        viewModel: viewModel
                    )
                    .frame(width: geo.size.width, height: geo.size.height)
                    .offset(y: viewModel.offsetForIndex(i))
                    .animation(.spring(response: 0.4,
                                       dampingFraction: 0.85),
                               value: viewModel.activeIndex)
                    .animation(.easeOut(duration: 0.15),
                               value: viewModel.dragOffset)
                    .gesture(verticalSwipe)
                }
            }
        }
    }

    // -----------------------------------------------------
    // MARK: VERTICAL SWIPE (NO COMMENTS CHECK)
    // -----------------------------------------------------

    var verticalSwipe: some Gesture {
        DragGesture()
            .onChanged { value in
                // Only block vertical scroll if horizontal profile gesture active
                if !viewModel.showingProfile {
                    viewModel.dragOffset = value.translation.height
                }
            }
            .onEnded { value in
                if !viewModel.showingProfile {
                    viewModel.handleVerticalSwipe(value.translation.height)
                }
            }
    }
}
