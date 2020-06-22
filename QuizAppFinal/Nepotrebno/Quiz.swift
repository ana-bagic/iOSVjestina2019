//
//  Quiz.swift
//  QuizAppFinal
//
//  Created by five on 06/06/2020.
//  Copyright © 2020 five. All rights reserved.
//

/*
import Foundation
import UIKit

class Quiz {
    
    let id: Int
    let title: String
    let description: String
    let category: Category
    let level: Int
    let image: String
    var questions: [Question] = []
    
    init?(json: Any) {
        
        if let jsonDict = json as? [String: Any],
            let id = jsonDict["id"] as? Int,
            let title = jsonDict["title"] as? String,
            let description = jsonDict["description"] as? String,
            let category = jsonDict["category"] as? String,
            let level = jsonDict["level"] as? Int,
            let image = jsonDict["image"] as? String,
            let jsonQuestions = jsonDict["questions"] as? [Any]
        {
            self.id = id
            self.title = title
            self.description = description
            if (category == "SPORTS") {
                self.category = Category.SPORTS
            }
            else {
                self.category = Category.SCIENCE
            }
            self.level = level
            self.image = image
            
            for quest in jsonQuestions {
                if let question = Question(json: quest) {
                    questions.append(question)
                }
            }
        }
        else {
            return nil
        }
    }
    
}
*/
