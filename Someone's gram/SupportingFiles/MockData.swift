//
//  MockData.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 21.03.2025.
//

import Foundation

struct Post: Codable {
    let id: String
    let username: String
    let avatar: String
    let image: String
    let description: String
    let likes: Int
    let createdAt: String
}


struct MockData {
    static let posts: [Post] = [
        Post(
            id: "1",
            username: "JohnDoe",
            avatar: "Cat1",
            image: "Dog1",
            description: "Mock post 1",
            likes: 10,
            createdAt: "2025-03-16T08:00:39Z"
        ),
        Post(
            id: "2",
            username: "JaneSmith",
            avatar: "Cat2",
            image: "Dog2",
            description: "Mock post 2",
            likes: 25,
            createdAt: "2025-03-16T08:00:39Z"
        ),
        Post(
            id: "3",
            username: "AliceWonder",
            avatar: "Cat3",
            image: "Dog3",
            description: "Exploring the beauty of nature 🌿",
            likes: 42,
            createdAt: "2025-03-16T08:00:39Z"
        )
    ]
}
