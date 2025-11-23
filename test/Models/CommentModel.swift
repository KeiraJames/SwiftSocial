//
//  CommentModel.swift
//  test
//
//  Created by Keira James on 11/23/25.
//

//
//  CommentModel.swift
//  test
//

import Foundation

struct CommentModel: Identifiable {
    let id = UUID()
    let username: String
    let text: String
    let likes: Int
}
