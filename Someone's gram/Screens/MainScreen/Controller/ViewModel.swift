//
//  ViewModel.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 17.03.2025.
//

import Foundation

class ViewModel {
    
    private let netvork = NetworkService()
//    
//    var isfetchingPost: ([PostEntity]) -> Void?
//    
    func fetchPost() -> [PostEntity]? {
        if CoreDataService.shared.isPostSaved() {
            return CoreDataService.shared.fetchSavedPosts()
        }
        return nil
    }
    
    func fetchData() {
        netvork.fetchPost(page: 1) {isPostSaved, error in
            if isPostSaved {
                print("данные можно отправлять")
            }
            if let error = error {
                AlertService.shared.showAlert(title: "Внимание", massage: "Проверьте подключение к сети интернет")
            }
        }
    }
}
