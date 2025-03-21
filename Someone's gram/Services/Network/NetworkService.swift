//
//  NetworkService.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class NetworkService {
    
    let apiKey = Bundle.main.apiKey
    private let baseUrl = "https://api.unsplash.com/photos"
    
    static var shared = NetworkService()
    
    private let imageCache = AutoPurgingImageCache() // Кеш изображений
    
    var useMockData = false // Флаг для использования моковых данных
    
    var prePage = 10
    
    init() {
        if CommandLine.arguments.contains("--use-mock-data") {
            useMockData = true
            prePage = 2
        }
    }
    
    
    func fetchPost(page: Int, completion: @escaping () -> Void) {
        
        if useMockData {
            saveMockPostsToCoreData()
            completion()
            return
        }
        
        let urlString = "\(baseUrl)?page=\(page)&pre_page=\(prePage)&client_id=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).validate().responseDecodable(of: [UnsplashPost].self) { response in
            switch response.result {
                
            case .success(let post):
                self.savePostsToCoreData(post)
                completion()
            case .failure(_):
                AlertService.shared.showAlert(title: "Внимание", massage: "Что-то пошло не так! Попробуйте еще раз")
            }
        }
    }
    
    private func savePostsToCoreData(_ posts: [UnsplashPost]) {
        let context = CoreDataService.shared.context
        
        for post in posts {
            let entity = PostEntity(context: context)
            entity.id = post.id
            entity.desc = post.description
            entity.imageUrl = post.urls.regular
            entity.likes = Int64(post.likes)
            entity.authorName = post.user.name
            entity.authorAvatar = post.user.profile_image.large
            entity.createdDate = post.created_at
            entity.isLiked = false
        }
        
        CoreDataService.shared.saveContext()
    }
    
    // Сохранение моковых данных в Core Data
    private func saveMockPostsToCoreData() {
        let context = CoreDataService.shared.context
        
        for post in MockData.posts {
            let entity = PostEntity(context: context)
            entity.id = post.id
            entity.desc = post.description
            entity.imageUrl = post.image
            entity.likes = Int64(post.likes)
            entity.authorName = post.username
            entity.authorAvatar = post.avatar
            entity.createdDate = post.createdAt
            entity.isLiked = false
        }
        
        CoreDataService.shared.saveContext()
    }
    
    func loadImage(from urlString: String, into imageView: UIImageView, completion: (() -> Void)? = nil) {
        
        if useMockData {
            imageView.image = UIImage(named: urlString) // Загружаем из Assets
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion?()
            return
        }
        
        // Проверяем, есть ли изображение в кеше
        if let cachedImage = imageCache.image(withIdentifier: urlString) {
            imageView.image = cachedImage
            completion?()
            return
        }
        
        // Загружаем изображение из сети
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                // Сохраняем в кэш
                self.imageCache.add(image, withIdentifier: urlString)
                
                DispatchQueue.main.async {
                    imageView.image = image
                    completion?()
                }
            case .failure(let error):
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                completion?()
            }
        }
    }
}
