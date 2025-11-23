📱 SwiftSocial

A social discovery app for places, activities, and experiences — built with SwiftUI (MVVM)

SwiftSocial helps users find activities, see which friends are interested, browse events, and book reservations in one tap. The UI is inspired by TikTok, Instagram, and Meetup — optimized for addictiveness, social proof, and frictionless action.

This project was built for the SwiftUI Track (Social Discovery UI) with a focus on product-market fit, ergonomic interaction design, and clean MVVM architecture.

⸻

🌟 Product Overview

Goal

Build an intuitive, scroll-based discovery interface that:
	•	Shows venues and activities
	•	Displays which friends/mutuals are interested
	•	Allows frictionless reservations
	•	Encourages users to attend places together
	•	Uses TikTok-style interactions to increase engagement

User Flow
	1.	Onboarding → Enter phone → Enter email → Choose left/right handed UI
	2.	FYP Video Feed → Swipe vertically to explore activities
	3.	Friend Interest Signals → Floating profile bubbles
	4.	Comments/Reviews → Mix of social comments + Google/Yelp reviews
	5.	Reservations → One-tap booking with success haptic + calendar confirmation
	6.	Search Page → Filter events by category, time, tags, and images
	7.	Profile Page → Swipe left to view creator or venue profile

⸻

🚀 Features 

📹 Immersive Video-Based Discovery

A TikTok-style full-screen video feed where you can:
	•	Swipe vertically
	•	View venue highlights
	•	See captions & profiles
	•	Immediately gauge if a place looks fun

This format is proven to create high engagement (TikTok/IG Reels UX research).

⸻

💸 Swipe FYP by Price Level ($ → $$$$)

Users can swipe between price tiers in the top navigation bar:
	•	$
	•	$$
	•	$$$
	•	$$$$

Why this is effective
	•	People budget-filter before choosing an activity
	•	Reduces cognitive load and choice fatigue
	•	Mimics TikTok’s “interest filtering,” which improves session duration
	•	Drives more relevant reservations

⸻

✋ Left-Handed / Right-Handed UI Personalization

During onboarding, users choose their dominant hand.
This repositions:
	•	Like/comment/share sidebar
	•	Floating friend bubbles
	•	Gesture hit zones

Why it increases retention

TikTok and Instagram both test UI weight adjustments based on hand ergonomics.
Dominant-hand UI reduces thumb travel distance → feels more natural → more addicting.

⸻

💛 One-Tap Reservation System

Designed for zero friction.

✔ Auto uses phone + email from onboarding
✔ No card prompt if the activity is free
✔ If paid → optional card popup (non-invasive)
✔ Smooth full-screen confirmation with success haptic
✔ Automatically returns to video feed

Why this works

People bail when asked to enter payment info upfront.
By delaying friction, conversion rates dramatically increase.

⸻

🫧 Floating “Friends Who Liked” Bubbles

Three floating circular avatars on the opposite side of the sidebar.

Why it boosts social discovery

Similar to Instagram’s “seen by friends” clusters:
	•	Builds trust
	•	Creates FOMO
	•	Encourages users to attend with others
	•	Makes venues feel more popular/active

⸻

💬 Smart Comments (Reviews + Social Comments)

Your comment section mixes:
	•	Google Review snippets
	•	Yelp summaries
	•	Real social comments

Why it’s smart

Users always check reviews before committing.
Bringing reviews into the scroll removes exit points and keeps the user in-app.

⸻

🔎 Meetup-Inspired Search View

Includes:
	•	Category carousel
	•	6+ event cards per scroll
	•	Real images (img1.jpg … img6.jpg)
	•	Tags, host, distance, date/time

Why this increases engagement

This replicates Meetup’s high-conversion pattern:
“Scroll → Skim → Save → Attend”

⸻

🎥 Gesture System
	•	Vertical swipe → next video
	•	Horizontal swipe → profile open
	•	Tap → pause
	•	Double tap → like
	•	Comment tap → opens comment sheet
	•	Price swipe → filter content

⸻

🗺 Minimal Map Integration

Simple map icon in the top-left for future venue navigation features.

⸻

🎨 Polished Visual Design
	•	Dark immersive theme (#0A0A2D)
	•	Floating layers & opacity animations
	•	MVVM separation
	•	Smooth haptics on interactions

⸻

🏗 Architecture

Pattern

Model → View → ViewModel (MVVM)
Clean SwiftUI structure with reactive @StateObject bindings.

Key Layers

/Models
    VideoItem.swift
    EventModel.swift
    HandPreference.swift

/ViewModels
    FYPViewModel.swift

/Views
    ContentView.swift
    FYP
        FYPView.swift
        VideoPage.swift
        CommentsSimpleView.swift
        ProfileView.swift
    Reservation
        ReservationFullScreen.swift
    Onboarding
        OnboardingCoordinator.swift
        PhoneEntryView.swift
        EmailEntryView.swift
        HandPreferenceView.swift
    Search
        SearchView.swift


⸻

🧩 High-Level Architecture Diagram

 ┌───────────────────────┐
 │      Onboarding       │
 │ phone → email → hand  │
 └──────────┬────────────┘
            │
            ▼
 ┌─────────────────────────┐
 │       ContentView        │
 │  ZStack = (Layers)       │
 │  - FYPView               │
 │  - ReservationOverlay    │
 │  - ProfileSlide          │
 │  - BottomNav             │
 └──────────┬───────────────┘
            │
            ▼
 ┌─────────────────────────┐
 │        FYPView          │
 │  Vertical Swipe Feed    │
 └──────────┬──────────────┘
            │
            ▼
 ┌─────────────────────────┐
 │       VideoPage         │
 │ (likes, comments,       │
 │  floating bubbles, etc.)│
 └─────────────────────────┘

 ➤ SearchView pulled from NavStack
 ➤ ReservationFullScreen overlays FYP


⸻

🛠 Installation & Setup

1️⃣ Clone the Repository

git clone https://github.com/yourusername/SwiftSocial.git
cd SwiftSocial

2️⃣ Open in Xcode

SwiftSocial.xcodeproj

3️⃣ Add your images

Place these in the root of the project (test/):

img1.jpg
img2.jpg
img3.jpg
img4.jpg
img5.jpg
img6.jpg
person1.jpg
person2.jpg
person3.jpg

4️⃣ Run on iOS Simulator

Requires:
	•	Xcode 15+
	•	iOS 17+ target

⸻

📚 Third-Party References & Inspiration
	•	TikTok Interaction Patterns — ByteDance UI/UX research on retention
	•	Instagram Friend Indicators — Meta’s social proof clustering
	•	Meetup Category UX — Scroll-based activity discovery
	•	Apple HIG — Haptics & animation guidelines
	•	Google/Yelp Review Structures — Used for comment fusion logic
