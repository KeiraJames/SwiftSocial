//
//  SearchView.swift
//  test
//

import SwiftUI

struct SearchView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    // Example event data
    let categories = ["All Events", "New", "Social", "Hobbies", "Sports"]
    @State private var selectedCategory = "All Events"

    let events: [EventModel] = [
        EventModel(title: "QC Spa Wellness Night",
                   host: "QC Terme",
                   date: "Today · 6:00 PM",
                   tags: ["Relaxing", "Spa"],
                   distance: "2.3 mi",
                   imageName: "img1"),

        EventModel(title: "Brush & Brew Painting Class",
                   host: "Brush & Brew",
                   date: "Tomorrow · 7:30 PM",
                   tags: ["Art", "Beginner Friendly"],
                   distance: "1.1 mi",
                   imageName: "img2"),

        EventModel(title: "Candle Making Workshop",
                   host: "Shine Studio",
                   date: "Friday · 5:00 PM",
                   tags: ["Creative", "Hands-on"],
                   distance: "4.2 mi",
                   imageName: "img3"),

        EventModel(title: "Glow Yoga with DJ",
                   host: "Zen House",
                   date: "Saturday · 9:00 AM",
                   tags: ["Fitness", "Music"],
                   distance: "3.7 mi",
                   imageName: "img4"),

        EventModel(title: "Salsa Night Social",
                   host: "Dance Loft",
                   date: "Friday · 8:00 PM",
                   tags: ["Dance", "Social"],
                   distance: "5.0 mi",
                   imageName: "img5"),

        EventModel(title: "Couples Pottery Class",
                   host: "Clay Co.",
                   date: "Sunday · 2:00 PM",
                   tags: ["Couples", "Hands-on"],
                   distance: "2.9 mi",
                   imageName: "img6")
    ]

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            // ----------------------------------------------------
            // TOP: Back Arrow + Search Bar
            // ----------------------------------------------------
            HStack(spacing: 12) {

                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }

                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search places or activities", text: $searchText)
                        .foregroundColor(.white)
                        .autocorrectionDisabled(true)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.14))
                .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .padding(.top, 25)
            .padding(.bottom, 12)

            // ----------------------------------------------------
            // CATEGORY CAROUSEL
            // ----------------------------------------------------
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(selectedCategory == cat ? .black : .white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                selectedCategory == cat
                                ? Color.white
                                : Color.white.opacity(0.14)
                            )
                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                                    selectedCategory = cat
                                }
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 5)
            }

            // ----------------------------------------------------
            // EVENT FEED (6 CARDS)
            // ----------------------------------------------------
            ScrollView {
                LazyVStack(spacing: 22) {
                    ForEach(events) { event in
                        EventCard(event: event)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(red: 10/255, green: 10/255, blue: 45/255)
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

////////////////////////////////////////////////////////////
// MARK: - EVENT MODEL
////////////////////////////////////////////////////////////

struct EventModel: Identifiable {
    let id = UUID()
    let title: String
    let host: String
    let date: String
    let tags: [String]
    let distance: String
    let imageName: String
}

////////////////////////////////////////////////////////////
// MARK: - EVENT CARD UI
////////////////////////////////////////////////////////////

struct EventCard: View {

    let event: EventModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            // THUMBNAIL (REAL IMAGE)
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(14)

            // EVENT INFO
            VStack(alignment: .leading, spacing: 6) {

                Text(event.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Text("Hosted by \(event.host)")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))

                Text(event.date)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)

                // TAGS
                HStack {
                    ForEach(event.tags, id: \.self) { tag in
                        Text(tag)
                            .font(.system(size: 12, weight: .medium))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(12)
                    }
                }

                Text(event.distance)
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 4)
            }
        }
        .padding(14)
        .background(Color.white.opacity(0.06))
        .cornerRadius(18)
    }
}
