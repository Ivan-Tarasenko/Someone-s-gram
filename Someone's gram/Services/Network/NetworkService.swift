//
//  NetworkService.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import Foundation
import Alamofire
import UIKit

class NetworkService {
    
    private let apiKay = "dFqOPQVcMwWo4EtD8R-K6PtZ8JsfTFysZ2z4hCH_TBw"
    private let baseUrl = "https://api.unsplash.com/photos"
    
    static var shared = NetworkService()
    
    init() {}
    
    
    func fetchPost(page: Int, prePage: Int = 10, completion: @escaping (Bool, Error?) -> Void) {
        let urlString = "\(baseUrl)?page=\(page)&pre_page=\(prePage)&client_id=\(apiKay)"
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).validate().responseDecodable(of: [UnsplashPost].self) { response in
            switch response.result {
                
            case .success(let post):
                self.savePhotosToCoreData(post)
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    private func savePhotosToCoreData(_ posts: [UnsplashPost]) {
        let context = CoreDataService.shared.context
        
        for post in posts {
            let entity = PostEntity(context: context)
            entity.id = post.id
            entity.desc = post.description
            entity.imageUrl = post.urls.regular
            entity.likes = Int64(post.likes)
            entity.authorName = post.user.name
            entity.authorAvatar = post.user.profile_image.large
        }
        
        CoreDataService.shared.saveContext()
        print("Фото сохранены в Core Data")
    }
    
    func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                }
            case .failure(let error):
                print("Ошибка при загрузке изображения: \(error.localizedDescription)")
            }
        }
    }
}
