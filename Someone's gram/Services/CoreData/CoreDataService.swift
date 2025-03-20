//
//  CoreDataService.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import Foundation
import CoreData

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Someone_s_gram")
        
//        print(container.persistentStoreDescriptions.first?.url as Any)          // принтит ссылку на базу
        
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // сохраняет данные
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("ERROR: \(error)")
            }
        }
    }
    
    // извлечение данных из базы
    func fetchSavedPosts() -> [PostEntity] {
        let context = CoreDataService.shared.context
        let fetshRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        do {
            return try context.fetch(fetshRequest)
        } catch {
            print("Failed to fetch posts: \(error)")
            return []
        }
    }
    
    // проверяем есть ли такой айди в базе
       func isPostSaved() -> Bool {
           let context = CoreDataService.shared.context
           let fetshRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
           do {
               return try context.fetch(fetshRequest).count > 0
           } catch {
               print("Failed to fetch posts: \(error)")
               return false
           }
   
       }
}

