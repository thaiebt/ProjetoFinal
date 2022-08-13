//
//  DataBaseController.swift
//  Um Gato Por Dia
//
//  Created by Thaina da Silva Ebert on 28/10/21.
//

import Foundation
import CoreData

class DataBaseController {
    
    // MARK: - Core Data stack

    //static para ser acessível
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "UmGatoPorDia")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func verifyFavorite(cat: CatsResponseModel) -> Bool {
        let context = DataBaseController.persistentContainer.viewContext
        do {
            guard let catIdentifier = cat.identifier else { return false}
            let fetchRequest = CatEntity.fetchRequest()
            let predicate = NSPredicate(format: "catIdentifier == %@", catIdentifier)
            fetchRequest.predicate = predicate
            
            let favoriteCat = try context.fetch(fetchRequest)
            if favoriteCat.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print("Error")
            return false
        }
    }
    
    static func removeFavorite(cat: CatsResponseModel) {
        guard let catIdentifier = cat.identifier else { return }
        let fetchRequest = CatEntity.fetchRequest()
        let predicate = NSPredicate(format: "catIdentifier == %@", catIdentifier)
        fetchRequest.predicate = predicate

        fetchRequest.includesPropertyValues = false

        let context = DataBaseController.persistentContainer.viewContext

        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        try? context.save()
    }
    
    static func addFavorites(catModel: CatsResponseModel) {
        if let catDescription = catModel.description,
           let catIdentifier = catModel.identifier,
           let catImage = catModel.image?.url,
           let catLifeSpan = catModel.lifeSpan,
           let catName = catModel.name,
           let catOrigin = catModel.origin,
           let catTemperament = catModel.temperament,
           let catWikipediaUrl = catModel.wikipediaUrl {
            
            let context = DataBaseController.persistentContainer.viewContext
            
            let cat = CatEntity(context: context)
            
            cat.catDescription = catDescription
            cat.catIdentifier = catIdentifier
            cat.catImage = catImage
            cat.catLifeSpan = catLifeSpan
            cat.catName = catName
            cat.catOrigin = catOrigin
            cat.catTemperament = catTemperament
            cat.catWikipediaUrl = catWikipediaUrl
            
            DataBaseController.saveContext()
        }
    }
    
    static func removeAllFavorites() {
        let context = DataBaseController.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CatEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)

        } catch {
            print("error")
        }
    }
}

