//
//  Models.swift
//  Instagram
//
//  Created by Vlad Panchenko on 26.04.2022.
//

import Foundation

public enum UserPostType {
    case photo, video
}

enum Gender {
    case male, famele, other
}

struct User {
    let username: String
    let bio: String
    let name:(first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage:URL
    let postUrl: URL
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser:[String]
}


struct PostLikes {
    let userName: String
    let commentIdentifier: String
}

struct CommentLikes {
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let commentorUsername: String
    let text: String
    let createDate: Date
    let likes:[CommentLikes]
}
