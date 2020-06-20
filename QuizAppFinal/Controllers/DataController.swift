//
//  DataController.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    static let shared = DataController()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchReviews() -> [Quiz]? {
        let request: NSFetchRequest<Quiz> = Quiz.fetchReviews
        
        // NSFetchRequestu mozemo postaviti NSPredicate koji sadrzi uvjete koje objekti trebaju zadovoljiti da bi se dohvatili (slicno kao WHERE u SQL)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let context = DataController.shared.persistentContainer.viewContext
        
        let quizzes = try? context.fetch(request)
        return quizzes
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
