//
//  Question+CoreDataClass.swift
//  QuizAppFinal
//
//  Created by five on 20/06/2020.
//  Copyright © 2020 five. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {

    class func getEntityName() -> String {
        return "Question"
    }
    
    class func firstOrCreate(withId id: Int) -> Question? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false

        do {
            let questions = try context.fetch(request)
            if let question = questions.first {
                return question
            }
            else {
                let newQuestion = Question(context: context)
                return newQuestion
            }
        }
        catch {
            return nil
        }
    }
    
    class func createFrom(json: Any) -> Question? {
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let question = jsonDict["question"] as? String,
            let answers = jsonDict["answers"] as? [String],
            let correct_answer = jsonDict["correct_answer"] as? Int {
            
            if let quest = Question.firstOrCreate(withId: id) {
                quest.question = question
                quest.correct_answer = correct_answer
                quest.a = answers[0]
                quest.b = answers[1]
                quest.c = answers[2]
                quest.d = answers[3]

                return quest
            }
        }
        return nil
    }
    
}
