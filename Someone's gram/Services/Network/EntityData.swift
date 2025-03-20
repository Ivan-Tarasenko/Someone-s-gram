//
//  EntityData.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import Foundation
struct UnsplashPost: Codable {
    let id: String
    let description: String?
    let urls: Urls
    let likes: Int
    let user: User
    let created_at: String
    
    struct Urls: Codable {
        let regular: String
    }
    
    struct User: Codable {
        let name: String
        let profile_image: ProfileImage
    }
    
    struct ProfileImage: Codable {
        let large: String
    }
}
