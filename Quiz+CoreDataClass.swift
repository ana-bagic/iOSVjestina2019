//
//  Quiz+CoreDataClass.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Quiz)
public class Quiz: NSManagedObject {

    class func getEntityName() -> String {
        return "Quiz"
    }
    
    class func firstOrCreate(withId id: Int) -> Quiz? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false

        do {
            let quizzes = try context.fetch(request)
            if let quiz = quizzes.first {
                return quiz
            }
            else {
                let newQuiz = Quiz(context: context)
                return newQuiz
            }
        }
        catch {
            return nil
        }
    }
    
    class func createFrom(json: Any) -> Quiz? {
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let category = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let image = jsonDict["image"] as? String,
            let jsonQuestions = jsonDict["questions"] as? [Any] {
            
            if let quiz = Quiz.firstOrCreate(withId: id) {
                quiz.title = title
                quiz.id = id
                quiz.desc = description
                quiz.category = category
                quiz.level = level
                quiz.image = image
                for quest in jsonQuestions {
                    quiz.addToQuestions(Question.createFrom(json: quest)!)
                }

                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                }
                catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
}
