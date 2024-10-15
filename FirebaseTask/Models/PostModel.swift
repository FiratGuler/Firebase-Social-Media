//
//  PostModel.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 8.10.2024.
//

import Foundation

struct PostModel: Codable {
    let postId : String
    let comments: [Comment]
    let date: String
    let image: String
    let postedBy: String
    

    func toDictionary() -> [String: Any] {
        return [
            "postId" : postId,
            "comments": comments.map { $0.toDictionary() },
            "date": date,
            "image": image,
            "postedBy": postedBy
        ]
    }
}

struct Comment: Codable {
    let comment: String
    let date: String
    let postedBy: String
    

    func toDictionary() -> [String: Any] {
        return [
            "comment": comment,
            "date": date,
            "postedBy": postedBy
        ]
    }
}
