////
////  CommentsSheet.swift
////  test
////
////  TikTok-style draggable comments panel
////  Multi-height snapping (small → medium → full)
////  Rounded top corners, no grab bar (Option B)
////
//
////
////  CommentsFullScreen.swift
////
//
//import SwiftUI
//
//struct CommentsFullScreen: View {
//
//    @ObservedObject var viewModel: FYPViewModel
//
//    var body: some View {
//        VStack {
//            // drag handle
//            Capsule()
//                .fill(Color.white.opacity(0.6))
//                .frame(width: 40, height: 6)
//                .padding(.top, 12)
//
//            Text("Comments")
//                .foregroundColor(.white)
//                .font(.headline)
//                .padding(.top, 8)
//
//            ScrollView {
//                VStack(spacing: 16) {
//                    ForEach(viewModel.comments) { c in
//                        HStack(alignment: .top, spacing: 12) {
//
//                            Circle()
//                                .fill(Color.gray.opacity(0.4))
//                                .frame(width: 36, height: 36)
//                                .overlay(
//                                    Text(String(c.username.prefix(1)))
//                                        .foregroundColor(.white)
//                                        .font(.system(size: 16, weight: .bold))
//                                )
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text("@\(c.username)")
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 14, weight: .semibold))
//
//                                Text(c.text)
//                                    .foregroundColor(.white.opacity(0.9))
//                                    .font(.system(size: 14))
//                            }
//
//                            Spacer()
//
//                            VStack {
//                                Image(systemName: "heart")
//                                    .foregroundColor(.white.opacity(0.7))
//                                Text("\(c.likes)")
//                                    .foregroundColor(.white.opacity(0.6))
//                                    .font(.system(size: 12))
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                }
//                .padding(.top, 12)
//            }
//
//            Spacer()
//
//            Button(action: { viewModel.closeComments() }) {
//                Text("Close")
//                    .foregroundColor(.white)
//                    .font(.system(size: 18, weight: .medium))
//                    .padding(.vertical, 18)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.red.opacity(0.7))
//            }
//        }
//        .background(Color.black.opacity(0.92))
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .transition(.move(edge: .bottom))
//        .ignoresSafeArea()
//    }
//}
