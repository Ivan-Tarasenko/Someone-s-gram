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
    
    private init() {
        if CommandLine.arguments.contains("--use-mock-data") {
            clearDatabase()

        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Someone_s_gram")
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
    func fetchSavedContext() -> [PostEntity] {
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
       func isSavedContext() -> Bool {
           let context = CoreDataService.shared.context
           let fetshRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
           do {
               return try context.fetch(fetshRequest).count > 0
           } catch {
               print("Failed to fetch posts: \(error)")
               return false
           }
       }
    
    func clearDatabase() {
        let context = self.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PostEntity")
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                guard let managedObject = object as? NSManagedObject else { continue }
                context.delete(managedObject)
            }
            try context.save()
        } catch {
            print("Failed to clear database: \(error.localizedDescription)")
        }
    }
}

