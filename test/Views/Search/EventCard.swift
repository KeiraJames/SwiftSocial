//import SwiftUI
//
//struct EventCard: View {
//
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 10) {
//  a
//            ZStack(alignment: .bottomLeading) {
//
//                // MAIN IMAGE
//                Image("video1_opt")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: 220)
//                    .clipped()
//                    .cornerRadius(18)
//
//                // PROFILE STACK + COUNT
//                HStack(spacing: -10) {
//
//                    ForEach(0..<3) { index in
//                        Image(systemName: "person.crop.circle")
//                            .resizable()
//                            .frame(width: 34, height: 34)
//                            .background(Color.black.opacity(0.3))
//                            .clipShape(Circle())
//                    }
//
//                    Text("13 going")
//                        .foregroundColor(.white)
//                        .font(.system(size: 14, weight: .semibold))
//                        .padding(.leading, 4)
//
//                }
//                .padding(12)
//
//            }
//
//            // TITLE
//            Text("Coming up: Influence Under the Writing!")
//                .foregroundColor(.white)
//                .font(.system(size: 18, weight: .semibold))
//
//            // DETAILS LINE
//            Text("TODAY • 4:30PM EST • Manhattan NY")
//                .foregroundColor(.gray)
//                .font(.system(size: 13))
//
//            // TAGS
//            HStack {
//                TagView("Writing")
//                TagView("Drinking")
//                TagView("Writer’s Block")
//            }
//        }
//    }
//}
//
//struct TagView: View {
//
//    let text: String
//
//    init(_ text: String) {
//        self.text = text
//    }
//
//    var body: some View {
//        Text(text)
//            .foregroundColor(.white)
//            .font(.system(size: 13, weight: .medium))
//            .padding(.vertical, 6)
//            .padding(.horizontal, 12)
//            .background(Color.white.opacity(0.12))
//            .cornerRadius(8)
//    }
//}
